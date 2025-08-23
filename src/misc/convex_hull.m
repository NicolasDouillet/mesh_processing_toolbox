function T = convex_hull(V)
% convex_hull : function to compute the 3D convex hull of a given
% point cloud (V) with the Jarvis / gift wrapping algorithm.
%
% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
%
% Output argument
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the convex hull triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]


tic

G = mean(V,1);
V = V - G; % to ensure [0 0 0] be inside the convex hull and for normals orientation matters
% V = V - [2 2 2];


% Body

% 1st vertex : the one minimum z
[~,v1] = mink(V(:,3),1);

% 2nd vertex
v2 = find_2nd_vertex(v1,V);

% 3rd vertex
first_edge = [v1, v2];
epsilon = eps;
[~,tgl1] = find_3rd_vertex(first_edge,V,epsilon);
T = tgl1;
edg_list = [T(1,1:2);T(1,2:3);T(1,[3 1])]; % nchoosek(tgl1,2);
curr_edge = edg_list(1,:);


% Il reste des non manifold triangles...

while ~isempty(edg_list)
        
    prev_tgl = T(cell2mat(find_triangle_indices_from_edg_list(T,curr_edge)),:);   
    opp_vtx_id = setdiff(prev_tgl,curr_edge);
    [new_tgl,~] = find_nxt_vertex(curr_edge,V,opp_vtx_id);
        
    % + condition : aucun des nouveau edges de ce nouveau triangle n'a déjà été traité !!! 
    % -> donc il faut choisir le bon new_tgl parmi une sélection à définir
    
    if ~isempty(new_tgl)
        
        T = cat(1,T,new_tgl);                        
        new_edg1 = new_tgl(1,2:3);                                     
        new_edg2 = [new_tgl(1,3),new_tgl(1,1)];
        edg_list(1,:) = [];
        
        if ~is_edge_already_processed(T,new_edg1)
            
            edg_list = cat(1,edg_list,new_edg1);
            
        end
        
        if ~is_edge_already_processed(T,new_edg2)
            
            edg_list = cat(1,edg_list,new_edg2);
            
        end
        
    end
        
    nxt_edge = [];
    
    while ~isempty(edg_list) || isempty(nxt_edge)
        
        if ~isempty(edg_list)
            
            if is_edge_already_processed(T,edg_list(1,:))
                
                edg_list(1,:) = [];
                
            else
                
                nxt_edge = edg_list(1,:);
                curr_edge = nxt_edge;
                break;
                
            end
            
        else
            
            break;
            
        end
        
    end
                    
end

fprintf('Mesh convex hull computed in %ds.\n',toc);


end % convex_hull


% is_edge_already_processed subfunction -> testée ok
function is_eap = is_edge_already_processed(T, edge)

is_eap = numel(find(sum(bitor(T == edge(1),T == edge(2)),2) == 2)) > 1;

end


% find_2nd_vertex subfunction
function vid2 = find_2nd_vertex(vid1, V)
% find_2nd_vertex : function to find the second vertex of the convex hull


vid2test = setdiff(1:size(V,1),vid1);
k = [0 0 1]; % Z axis unit vector
vector21stvtx = V(vid2test,:)-V(vid1,:);
dist21stvtx = sqrt(sum(vector21stvtx.^2,2));
theta = atan2(sqrt(sum(cross(repmat(-k,[size(V,1)-1,1]),vector21stvtx,2).^2,2)),(vector21stvtx*(-k)'));
nxt_vtx_id = find(theta == min(theta)); % the smallest one
% find(dist21stvtx(nxt_vtx_id) == max(dist21stvtx(nxt_vtx_id))) % to check indices are good
nxt_vtx_id = vid2test(nxt_vtx_id(dist21stvtx(nxt_vtx_id) == max(dist21stvtx(nxt_vtx_id)))); % the furthest one
vid2 = nxt_vtx_id(1,1);


end % find_2nd_vertex


% find_3rd_vertex subfunction
function [vid3, tgl1] = find_3rd_vertex(first_edge, V, epsilon)
% find_3rd_vertex : function to find the third vertex of the convex hull


new_tgl = zeros(0,3);
vid3 = [];

% Candidate vertices and triangles
vid2test = setdiff(1:size(V,1),first_edge);
tglist = cat(2,repmat(first_edge,[size(V,1)-2,1]),vid2test');
G = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(tglist,2),'un',0));

% Normal vectors
tgl_normals = cross(V(tglist(:,3),:)-V(tglist(:,1),:),V(tglist(:,2),:)-V(tglist(:,1),:),2);

for i = 1:numel(vid2test)
    
    cnd_vtx_vect = V(vid2test,:) - G(i,:); 
    cnd_vtx_vect = cnd_vtx_vect ./ sqrt(sum(cnd_vtx_vect.^2,2));
    
    dot_prod = dot(cnd_vtx_vect,tgl_normals,2);
    dot_prod(abs(dot_prod) < epsilon) = 0;
    sgn_dot_prod = sign(dot_prod);  
    
    if isequal(sgn_dot_prod,abs(sgn_dot_prod)) % native outward oriented triangles concatenation
        
        new_tgl = cat(1,new_tgl,tglist(i,:));
        vid3 = cat(2,vid3,vid2test(i));
        
    elseif isequal(sgn_dot_prod,-abs(sgn_dot_prod)) % native inward oriented triangles reorientation + concatenation
        
        new_tgl = cat(1,new_tgl,fliplr(tglist(i,:)));
        vid3 = cat(2,vid3,vid2test(i));
        
    end
    
end

% Here now numel(vid3) >= 2

% Keep the fursthest only
u0 = V(first_edge(2),:) - V(first_edge(1),:); 
dist2edg = point_to_line_distance(V(vid3,:),u0,V(first_edge(1),:));
max_dst_vid = dist2edg == max(dist2edg);
vid3 = vid3(max_dst_vid);
vid3 = vid3(1,1);
tgl1 = new_tgl(max_dst_vid,:);
tgl1 = tgl1(1,:);


end % find_3rd_vertex


% find_nxt_vertex subfunction
function [new_tgl,nxt_vtx_id] = find_nxt_vertex(curr_edge, V, opp_vtx_id)
% find_nxt_vertex : function to find the next vertices in the algorithm
% given a current edge. These candidate new vertices are the ones which
% build a triangle which has all the other vertices of the point set on one
% same unique side.


vid2test = setdiff(1:size(V,1),[curr_edge,opp_vtx_id]); % vertex ids to tests
u0 = V(curr_edge(2),:)-V(curr_edge(1),:);

[~,H_prev] = point_to_line_distance(V(opp_vtx_id,:),u0,V(curr_edge(1),:));
vector2edge_prev = V(opp_vtx_id,:) - H_prev;  
    
[dist2edge_nxt,H_nxt] = point_to_line_distance(V(vid2test,:),u0,V(curr_edge(1),:));
vector2edge_nxt = V(vid2test,:) - H_nxt;


% opp_vtx_id
% size(repmat(vector2edge_prev,[numel(vid),1]))
% size(vector2edge_nxt)

theta = atan2(sqrt(sum(cross(repmat(vector2edge_prev,[numel(vid2test),1]),vector2edge_nxt,2).^2,2)),vector2edge_nxt*vector2edge_prev');

nxt_vtx_id = find(theta == max(theta)); % the largest angle
nxt_vtx_id = vid2test(nxt_vtx_id(dist2edge_nxt(nxt_vtx_id) == max(dist2edge_nxt(nxt_vtx_id)))); % the furthest vertex
nxt_vtx_id = nxt_vtx_id(1,1);
new_tgl = cat(2,flip(curr_edge),nxt_vtx_id);


end % find_new_vertex