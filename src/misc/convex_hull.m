function T = convex_hull(V)
%% convex_hull : function to compute the 3D convex hull of a given
% point cloud with the Jarvis / gift wrapping algorithm.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%
% Output argument
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the convex hull triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]


%% Body
tic
assert(size(V,1) > 3,'Error : vertex set V must contain at least four non coplanar vertices to be 3D.');

coeff = 1;
epsilon = coeff*eps; % floating point tolerance error
nb_vtx = size(V,1); % nb vertices

% 1st vertex : the one minimum z
[~,v1] = mink(V(:,3),1);

% 2nd vertex : the one which build an edge with minimum (positive) dot product with k [0 0 1] vector
d = dot(V-V(v1,:),repmat([0 0 1],[size(V,1),1]),2);
[~,v2] = mink(d,2);   
v2 = setdiff(v2,v1); % remove dot prod with null vector

curr_edge = [v1 v2]; % initial edge
edge_list = curr_edge;
proc_edge_list = zeros(0,2); % processed edge list
T = zeros(0,3);
curr_edge_id = 1;


while ~isempty(curr_edge)
    
    [new_tgl,nxt_vtx_id] = find_nxt_vertex(curr_edge,V,nb_vtx,epsilon); % next vertices
    proc_edge_list = cat(1,proc_edge_list,curr_edge);
    curr_edge_id = curr_edge_id + 1;
    
    % Non already existing new triangles
    idx2keep = ~ismember(sort(new_tgl,2),sort(T,2),'rows');
    new_tgl = new_tgl(idx2keep,:);
    nxt_vtx_id = nxt_vtx_id(idx2keep);    
    
    
    if ~isempty(new_tgl)
        
        T = cat(1,T,new_tgl); % add triangles        
        
        % Create and add the two new edges
        new_edg1 = cat(2,repmat(curr_edge(1),[numel(nxt_vtx_id),1]),nxt_vtx_id');
        new_edg2 = cat(2,repmat(curr_edge(2),[numel(nxt_vtx_id),1]),nxt_vtx_id');                
        edge_list = cat(1,edge_list,new_edg1,new_edg2);
        
    end
        
    % Compute new edge index to process
    if curr_edge_id < 1 + size(edge_list,1)
        
        nxt_edg = edge_list(curr_edge_id,:);
        
        if ~ismember(sort(nxt_edg,2),sort(proc_edge_list,2),'rows')
            
            curr_edge = nxt_edg;
            
        end
        
    else
        
        curr_edge = [];
        
    end
    
end


fprintf('Mesh convex hull computed in %ds.\n',toc);


end % convex_hull


%% find_nxt_vertex subfunction
function [new_tgl,nxt_vtx_id] = find_nxt_vertex(edge, V, nb_vtx, epsilon)
% find_nxt_vertex : function to find the next vertices in the algorithm
% given a current edge. These candidate new vertices are the ones which
% build a triangle which has all the other vertices of the point set on one
% same unique side.


new_tgl = zeros(0,3);
nxt_vtx_id = [];

% Candidate triangles
vtx_id2test = setdiff(1:nb_vtx,edge);
tglist = cat(2,repmat(edge,[nb_vtx-2,1]),vtx_id2test');
G = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(tglist,2),'un',0));

% Normal vectors
tgl_normals = cross(V(tglist(:,3),:)-V(tglist(:,1),:),V(tglist(:,2),:)-V(tglist(:,1),:),2);


for i = 1:numel(vtx_id2test)
    
    cnd_vtx_vect = V(vtx_id2test,:) - repmat(G(i,:),[nb_vtx-2,1]); 
    cnd_vtx_vect = cnd_vtx_vect ./ sqrt(sum(cnd_vtx_vect.^2,2));
    
    dot_prod = dot(cnd_vtx_vect,tgl_normals,2);
    dot_prod(abs(dot_prod) < epsilon) = 0;
    sgn_dot_prod = sign(dot_prod);  
    
    if isequal(sgn_dot_prod,abs(sgn_dot_prod)) % native outward oriented triangles concatenation
        
        new_tgl = cat(1,new_tgl,tglist(i,:));
        nxt_vtx_id = cat(2,nxt_vtx_id,vtx_id2test(i));
        
    elseif isequal(sgn_dot_prod,-abs(sgn_dot_prod)) % native inward oriented triangles reorientation + concatenation
        
        new_tgl = cat(1,new_tgl,fliplr(tglist(i,:)));
        nxt_vtx_id = cat(2,nxt_vtx_id,vtx_id2test(i));
        
    end
    
end


end % find_new_vertex