function srt_itx_vtx_lsts = slice_mesh(V, T, n, P, substripe_selection, slices_nb_max_contours, sort_direction, slc_step)
%% slice_mesh : function to slice one given triangular mesh.
%
% Author : nicolas.douillet (at) free.fr, 2023-2024.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [|  |  | ]
%
% - n = [nx ny nz], real row vector double, one plane normal vector, size(n) = [1,3].
%
% - P = [Px Py Pz], real row vector double, one point belonging to the slicing plane, size(P) = [1,3].
%
% - substripe_selection : either logical, *true/false or numeric *1/0, boolean to enable/diasable the substripe selection.
%
% - slices_nb_max_contours : positive integer scalar double, 
%
% - sort_direction : character string in the set {'horizontal', 'vertical'}, case insensitive, the sorting direction of the slice contours.
%
% - slc_step : positive integer scalar double, the slicing step in graphic unit of the point set.
%
%
% Output arguments
%
% - srt_itx_vtx_lsts : cell array of integer vectors double, the sorted intersection vertex list.
%                      size(srt_itx_vtx_lsts) = [nb_contours,1], where nb_contours is the number
%                      of contours in the slice.


%% Body
Perim = @(P)sum(sqrt(sum(diff(P(:,:),1).^2,2)),1);


% I Find and sort triangles
% 1.1 Look for candidate edges
% Sub horizontal mesh selection

% /_!_\ caution : sensitive coefficient to adjust /_!_\ : 
mesh_substripe_margin_coeff = 8;
% function of slicing step, meshing technique and simplification

if substripe_selection
    
    M = sum(n.*P,2);
    [V,T] = select_mesh_substripe(V,T,n,M,mesh_substripe_margin_coeff*slc_step);
    
end

T = unique(sort(T,2,'ascend'),'rows');
raw_edges_list = query_edges_list(T,'sorted');
edges_list = unique(raw_edges_list,'rows');
nb_edges = size(edges_list,1);
itx_edg_lst = []; % intersecting edges list


for i = 1:nb_edges
    
    V1 = V(edges_list(i,1),:);
    V2 = V(edges_list(i,2),:);
    
    [~,H1] = point_to_plane_distance(V1,n,P);
    [~,H2] = point_to_plane_distance(V2,n,P);
    
    h1v1 = V1 - H1;
    h2v2 = V2 - H2;
   
    s1 = sign(dot(h1v1,n));
    s2 = sign(dot(h2v2,n));
    
    if (sign(s2) == -sign(s1)) | (s1 == 0 & s2 == 0)
        
        itx_edg_lst = cat(1,itx_edg_lst,edges_list(i,:)); % edges are unique in this list
                                                          % and all shared by -at least- two triangles            
    end
    
end


if ~isempty(itx_edg_lst)
        
    % Find every corresponding unique triangles
    tgl_idx_list = find_triangle_indices_from_edges_list(T,itx_edg_lst);
    
    % 1.2 Sort / connect edges ; to get new intersection vertices well sorted too
    srt_itx_edg_lsts = {};
    go_on = 1; % first while loop continuing conditions
        
    while go_on
               
        % Output list initialization
        srt_itx_edg_lst = zeros(0,2);             
        
        % 1st edge special case processing
        % first one not already in srt_itx_edg_lst
        % Detect edges belonging to boundaries of the mesh
        if ~isempty(srt_itx_edg_lsts)
            
            first_row_idx = find(~ismember(itx_edg_lst,cell2mat(srt_itx_edg_lsts),'rows'),1,'first');
            
        else
            
            first_row_idx = 1;
            
        end
        
        if first_row_idx
            
            first_cdt_row_idc = cell2mat(tgl_idx_list(first_row_idx,1));
            
        else
            
            first_row_idx = first_row_idx + 1;
            
        end
        
        first_tgl_idx = first_cdt_row_idc(1,1);
        first_tgl = sort(nchoosek(T(first_tgl_idx,:),2),2);
        first_edge = itx_edg_lst(first_row_idx,:);
             
        % List update : always cat first edge
        if ~isempty(first_edge) & ~ismember(first_edge,srt_itx_edg_lst,'rows')
            
            srt_itx_edg_lst = cat(1,srt_itx_edg_lst,first_edge);
            
        end
        
        [~,curr_edge_pos] = ismember(first_edge,first_tgl,'rows');
        curr_row_idx = find_nxt_edg_idx(itx_edg_lst,first_tgl,curr_edge_pos);                
        curr_edge = itx_edg_lst(curr_row_idx,:);
              
        % Update list
        if ~isempty(curr_edge) & ~ismember(curr_edge,srt_itx_edg_lst,'rows')
            
            srt_itx_edg_lst = cat(1,srt_itx_edg_lst,curr_edge);
            
        end
        
        curr_cdt_row_idc = cell2mat(tgl_idx_list(curr_row_idx,1));
        curr_tgl_idx = setdiff(curr_cdt_row_idc,first_tgl_idx);
        
        if isequal(size(T(curr_tgl_idx,:)),[1,3])
            
            curr_tgl = sort(nchoosek(T(curr_tgl_idx,:),2),2);
            
        else
            
            break;
            
        end
        
        prev_row_idx = -Inf;
        curr_row_idx_list = curr_row_idx;
        
        stop_flag = false;
        go_on2 = curr_row_idx & ~stop_flag; % second nested while loop continuing conditions
        
        while go_on2
                        
            % Position of the edge in its triangle : 1, 2, or 3
            [~,curr_edge_pos] = ismember(curr_edge,curr_tgl,'rows');
            nxt_row_idx = find_nxt_edg_idx(itx_edg_lst,curr_tgl,curr_edge_pos);
            
            if nxt_row_idx & ~stop_flag
                
                nxt_edge = itx_edg_lst(nxt_row_idx,:);
                       
                % Update list
                if ~isempty(nxt_edge)
                    
                    srt_itx_edg_lst = cat(1,srt_itx_edg_lst,nxt_edge);
                    
                end
                
                nxt_cdt_row_idc = cell2mat(tgl_idx_list(nxt_row_idx,1));
                nxt_tgl_idx = setdiff(nxt_cdt_row_idc,curr_tgl_idx);
                
                if nxt_tgl_idx & isvector(T(nxt_tgl_idx,:)) & ~stop_flag
                    
                    nxt_tgl = sort(nchoosek(T(nxt_tgl_idx,:),2),2); % different from immediate previous one
                    
                    % Update variables
                    prev_row_idx = curr_row_idx;
                    curr_row_idx = nxt_row_idx;
                    curr_row_idx_list = cat(2,curr_row_idx_list,curr_row_idx);
                    curr_tgl_idx = nxt_tgl_idx;
                    curr_tgl = nxt_tgl;
                    curr_edge = nxt_edge;
                    
                else
                    
                    nxt_row_idx = 0;
                    stop_flag = true;
                    break;
                    
                end
                       
                % Update list
                if ~isempty(curr_edge)
                    srt_itx_edg_lst = cat(1,srt_itx_edg_lst,curr_edge);
                end
                
            else
                
                stop_flag = true;
                break;
                
            end
            
            go_on2 = (~stop_flag & curr_row_idx) & (curr_row_idx ~= prev_row_idx) & ~isequal(nxt_edge,first_edge);
            
        end
        
        if ~isempty(srt_itx_edg_lst) & size(srt_itx_edg_lst,1) > 2 % at least 3 edges
            
            srt_itx_edg_lsts = cat(1,srt_itx_edg_lsts,{srt_itx_edg_lst});
            
        end
        
        go_on = ~isequal(unique(cell2mat(srt_itx_edg_lsts),'rows'),...
            unique(itx_edg_lst,'rows'));
        
    end            
    
    % Cleaning meaningless small perimeters
    if size(srt_itx_edg_lsts,1) > slices_nb_max_contours
        
        perim_vect = zeros(size(srt_itx_edg_lsts,1),1);
        
        for k = 1:size(srt_itx_edg_lsts,1)
            
            perim_vect(k,1) = Perim(cell2mat(srt_itx_edg_lsts(k,1)));
            
        end
        
        [~,idx_sort] = sort(perim_vect,1,'descend');
        srt_itx_edg_lsts = srt_itx_edg_lsts(idx_sort,1);
        srt_itx_edg_lsts = srt_itx_edg_lsts(1:slices_nb_max_contours,1);
        
    end            
    
    % III Compute intersecting -new- vertices and store them in a list
    % Simultaneous bboxes and G arrays creation
    nb_contours = size(srt_itx_edg_lsts,1);
    srt_itx_vtx_lsts = cell(nb_contours,1);
    bbxes = zeros(nb_contours,4); % [xmin, xmax, ymin, ymax]
    CDG = zeros(nb_contours,3); % [x_G, y_G z_G]
    
    for i = 1:size(srt_itx_edg_lsts,1)
        
        curr_contour = cell2mat(srt_itx_edg_lsts(i,1));
        srt_itx_vtx_lst = [];
        
        for j = 1:size(curr_contour,1)
            
            curr_edg = curr_contour(j,:);
            V1 = V(curr_edg(1,1),:);
            V2 = V(curr_edg(1,2),:);
            
            I = line_plane_intersection(V2-V1,V1,n,P);
            
            srt_itx_vtx_lst = cat(1,srt_itx_vtx_lst,I);
            
        end
        
        if ~isempty(unique(srt_itx_vtx_lst,'rows')) & size(srt_itx_vtx_lst,1) > 2 % at least 3 vertices
            
            x_G = mean(srt_itx_vtx_lst(:,1));
            y_G = mean(srt_itx_vtx_lst(:,2));
            z_G = mean(srt_itx_vtx_lst(:,3));
            
            x_min = min(srt_itx_vtx_lst(:,1));
            y_min = min(srt_itx_vtx_lst(:,2));
            x_max = max(srt_itx_vtx_lst(:,1));
            y_max = max(srt_itx_vtx_lst(:,2));
            
            CDG(i,:) = [x_G,y_G,z_G];
            bbxes(i,:) = [x_min,x_max,y_min,y_max];
            
            srt_itx_vtx_lsts(i,1) = {srt_itx_vtx_lst};
            
        end
        
    end    
    
    % Cleaning inside meaningless perimeters
    % Find contours which CDG belongs to
    % The bboxe of another contour
    nb_contours = size(srt_itx_vtx_lsts,1);
    F = zeros(nb_contours,nb_contours);
    F = F - diag(ones(1,nb_contours));
    
    for n = 1:nb_contours
        
        for p = setdiff(1:size(bbxes,1),n)
            
            if CDG(n,1) > bbxes(p,1) & CDG(n,1) < bbxes(p,2) & ...
                    CDG(n,2) > bbxes(p,3) & CDG(n,2) < bbxes(p,4) ...
                    & Perim(cell2mat(srt_itx_vtx_lsts(n,1))) < Perim(cell2mat(srt_itx_vtx_lsts(p,1)))
                
                F(n,p) = 1;
                
            end
            
        end
        
    end
        
    % Suppress nested contours & update arrays
    f = find(F == 1);
    [i,~] = ind2sub([nb_contours,nb_contours],f);
    srt_itx_vtx_lsts = srt_itx_vtx_lsts(setdiff(1:nb_contours,i),:);
    CDG = CDG(setdiff(1:nb_contours,i),:);
    
    if strcmpi(sort_direction,'horizontal') % Left - center - right perimeters sort
        
        [~,srt_idx] = sort(CDG(:,2),'descend'); % -> from left to right
        srt_itx_vtx_lsts = srt_itx_vtx_lsts(srt_idx,:);
        
    elseif strcmpi(sort_direction,'vertical') % Up - down sort
        
        [~,srt_idx] = sort(CDG(:,3),'descend'); % -> from top to bottom
        srt_itx_vtx_lsts = srt_itx_vtx_lsts(srt_idx,:);
        
    else % if strcmpi(sort_direction,'none') or any other string
    
    % Do not sort, do nothing
        
    end
        
else
    
    srt_itx_vtx_lsts = {};
    
end


end % slice_mesh


%% find_edg_idx subfunction
function nxt_row_idx = find_nxt_edg_idx(itx_edg_lst,curr_tgl,curr_edge_pos)


ngb_edg_idx = setdiff([1 2 3],curr_edge_pos);
ngb_edg1 = curr_tgl(ngb_edg_idx(1),:);
ngb_edg2 = curr_tgl(ngb_edg_idx(2),:);

[~,idx1] = ismember(itx_edg_lst,ngb_edg1,'rows');

fidx1 = idx1(find(idx1));
idx1 = find(idx1);
[~,sidx1] = sort(fidx1,'ascend');
idx1 = idx1(sidx1);

[~,idx2] = ismember(itx_edg_lst,ngb_edg2,'rows');
fidx2 = idx2(find(idx2));
idx2 = find(idx2);
[~,sidx2] = sort(fidx2,'ascend');
idx2 = idx2(sidx2);

if idx1
    
    nxt_row_idx = idx1;
    
elseif idx2
    
    nxt_row_idx = idx2;
    
else
    
    nxt_row_idx = 0;
    
end


end % find_nxt_edg_idx