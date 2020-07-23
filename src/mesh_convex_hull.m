function [T] = mesh_convex_hull(V)
% mesh_convex_hull : function to compute the 3D convex hull of a given
% point cloud with the Jarvis / gift wrapping algorithm.
%
% Author & support nicolas.douillet (at) free.fr, 2020.
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


tic
assert(size(V,1) > 3,'Error : vertex set V must contain at least four non coplanar vertices to be 3D.');

nb_vtx = size(V,1); % nb vertices
epsilon = 1e8*eps; % floating point tolerance error

% 1st vertex : the one with z_min
[~,v1] = min(V(:,3));
if v1; v1 = v1(1,1); end

% 2nd vertex : the one which build an edge with minimum (positive) dot product with k [0 0 1] vector
U = V - repmat(V(v1,:),[nb_vtx,1]);
d = dot(U,repmat([0 0 1],[nb_vtx,1]),2);
[~,v2] = mink(d,2); 
v2 = setdiff(v2,v1); % remove dot prod with null vector

% 3rd vertex : the one which define the plane such that all the other
% vertices (except v1 & v2) remain in only one single and unique side of
% this plane (v1,v2,v3) -dot product of constant or null sign with the plane normal vector-

edg = [min([v1,v2]),max([v1,v2])];
curr_edg = edg;
edg_list = edg;
T = zeros(0,3);
curr_edg_idx = 1;


while ~isempty(curr_edg)
   
    nxt_vtc = find_nxt_vertex(curr_edg,V,nb_vtx,epsilon);   
    nb_tgl = numel(nxt_vtc);
    tgl = sort(cat(2,repmat(curr_edg,[nb_tgl,1]),nxt_vtc'),2);
    new_tgl = [];
    
    for s = 1:nb_tgl                
        
        if isempty(find(all(bsxfun(@eq,T,tgl(s,:)),2),1)) % not already exists
            
            new_tgl = cat(1,new_tgl,tgl(s,:));                        
            
        end
        
    end       
    
    
    if ~isempty(new_tgl)
        
        T = cat(1,T,new_tgl);
        
        for s = 1:nb_tgl % ou requery
            
            edg_list = cat(1,edg_list,sort(cat(2,curr_edg',[nxt_vtc(1,s);nxt_vtc(1,s)]),2));
            
        end
        
    end
        
    curr_edg_idx = curr_edg_idx + 1;
            
    if curr_edg_idx < 1 + size(edg_list,1)
        
        curr_edg = edg_list(curr_edg_idx,:); 
        
    else
        
        curr_edg = [];
        
    end    
    
end

fprintf('Mesh convex hull computed in %ds.\n',toc);


end % mesh_convex_hull


function [nxt_vtc] = find_nxt_vertex(edg, V, nb_vtx, epsilon)


nxt_vtc = [];

% Candidate triangles
idx_vect = setdiff(1:nb_vtx,edg);
cnd_tgl = cat(2,repmat(edg,[nb_vtx-2,1]),idx_vect');
G = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(cnd_tgl,2),'UniformOutput',false));

% Normalized normal vectors
cnd_tgl_norm_vect = cross(V(cnd_tgl(:,3),:)-V(cnd_tgl(:,1),:),V(cnd_tgl(:,2),:)-V(cnd_tgl(:,1),:),2);
cnd_tgl_norm_vect = cnd_tgl_norm_vect ./ sqrt(sum(cnd_tgl_norm_vect.^2,2));


for i = 1:numel(idx_vect)
    
    cnd_vtx_vect = V(idx_vect,:) - repmat(G(i,:),[nb_vtx-2,1]); 
    cnd_vtx_vect = cnd_vtx_vect ./ sqrt(sum(cnd_vtx_vect.^2,2));
    
    dot_prod = dot(cnd_vtx_vect,cnd_tgl_norm_vect,2);
    dot_prod(abs(dot_prod) < epsilon) = 0;
    sgn_dot_prod = sign(dot_prod);  
    
    if isequal(sgn_dot_prod,abs(sgn_dot_prod)) || isequal(sgn_dot_prod,-abs(sgn_dot_prod))
        
        nxt_vtc = cat(2,nxt_vtc,idx_vect(i));
        
    end
    
end


end % find_new_vertex