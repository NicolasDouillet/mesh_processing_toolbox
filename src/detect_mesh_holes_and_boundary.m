function boundaries = detect_mesh_holes_and_boundary(T)
%% detect_mesh_holes_and_boundary : function to detect vertices which are part of
% the mesh boundary and list their indices in boundary vectors.
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2023.
%                                         
% From the vertex and triangle lists, this function computes
% the mesh boundaries when there are some (opened surface
% or presence of holes in the mesh).
%
% Principle is based on detecting and sorting non shared edges.  
%
%
% Input arguments
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%
% Output argument
%
% - boundaries : cell array of positive integer row vectors double, size(boundaries) = [nb_holes,1].


%% Body
tic;

% Build  lists
raw_edges_list = query_edges_list(T);
[~,~,iu] = unique(sort(raw_edges_list,2),'rows'); % unique(raw_edges_list,'rows');

% Unique edges only (even in mirror)
[i3,i4] = histc(iu,unique(iu));
lone_edges_idx_vect = i3(i4) == 1;
lone_edges_list = raw_edges_list(lone_edges_idx_vect,:);
boundaries = {};

while ~isempty(lone_edges_list)
    
    first_vtx_idx = lone_edges_list(1,1);
    nxt_vtx_idx   = lone_edges_list(1,2);
    boundary = [first_vtx_idx,nxt_vtx_idx] ;
    lone_edges_list = lone_edges_list(2:end,:);
    
    % Nb holes / boundaries times
    while nxt_vtx_idx ~= first_vtx_idx % && ~isempty(nxt_vtx_idx)
                       
        i = find(any(lone_edges_list == nxt_vtx_idx,2));
        nxt_edge = lone_edges_list(i,:);
        
        nxt_vtx_idx = setdiff(nxt_edge,nxt_vtx_idx); % must be the unique shared vertex beteween these two edges        
        
        % Fill boundary
        if ~isempty(nxt_vtx_idx)
            boundary = cat(2,boundary, nxt_vtx_idx);
        end
        
        % Update / dequeue lone_edges_list        
        lone_edges_list(i,:) = [];
        
    end
    
    if numel(unique(boundary)) > 2 % at least 3 different vertices
        boundaries = cat(1,boundaries, {boundary(1,1:end-1)});
    end
    
end


% Number of vertices descending order sort
bound_nb_vtx = zeros(size(boundaries,1),1);

for n = 1:size(boundaries,1)
    
    bound_nb_vtx(n,1) = numel(cell2mat(boundaries(n,1)));
    
end

[~,srt_idx] = sort(bound_nb_vtx,'descend'); % ~ : srt_bound_nb_vtx
boundaries = boundaries(srt_idx,:);
nb_holes = size(boundaries,1);

fprintf('%d boundaries detected in %d seconds.\n',nb_holes,toc);


end % detect_mesh_holes_and_boundary