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


% Body
tic
assert(size(V,1) > 3,'Error : vertex set V must contain at least four non coplanar vertices to be 3D.');

nb_vtx = size(V,1); % nb vertices
epsilon = 1e4*eps; % floating point tolerance error

% 1st vertex : the one with z_min
[~,v1] = min(V(:,3));
if v1; v1 = v1(1,1); end

% 2nd vertex : the one which build an edge with minimum (positive) dot product with k [0 0 1] vector
U = V - repmat(V(v1,:),[nb_vtx,1]);
d = dot(U,repmat([0 0 1],[nb_vtx,1]),2);
[~,v2] = mink(d,2); 
v2 = setdiff(v2,v1); % remove dot prod with null vector

curr_edg = [min([v1,v2]),max([v1,v2])]; % initial edge
edg_list = curr_edg;
proc_edg_list = zeros(0,2); % processed edge list
T = zeros(0,3);
curr_edg_idx = 1;


while ~isempty(curr_edg)
   
    nxt_vtc = find_nxt_vertex(curr_edg,V,nb_vtx,epsilon); % next vertices
    nb_tgl = numel(nxt_vtc); % number of new triangles
    tgl = sort(cat(2,repmat(curr_edg,[nb_tgl,1]),nxt_vtc'),2); % newly potential triangles created
    new_tgl = zeros(0,3);        
    
    for s = 1:nb_tgl                                
        
        if isempty(find(all(bsxfun(@eq,T,tgl(s,:)),2),1))
                        
            new_tgl = cat(1,new_tgl,tgl(s,:));           
            
        end
        
    end
    
    
    if ~isempty(new_tgl)
        
        T = cat(1,T,new_tgl); % add valid new triangles
        
        for s = 1:nb_tgl
            
            % create the two new edges
            new_edg1 = sort([curr_edg(1,1),nxt_vtc(1,s)]);
            new_edg2 = sort([curr_edg(1,2),nxt_vtc(1,s)]);
            
            % Add valid new edges
            if isempty(find(all(bsxfun(@eq,new_edg1,edg_list),2),1)) % ~ismember(new_edg1,edg_list,'rows')
                
                edg_list = cat(1,edg_list,new_edg1);
                
            end
            
            if isempty(find(all(bsxfun(@eq,new_edg2,edg_list),2),1)) % ~ismember(new_edg2,edg_list,'rows')
                
                edg_list = cat(1,edg_list,new_edg2);
                
            end
            
        end
        
    end    
       
    proc_edg_list = cat(1,proc_edg_list,curr_edg);
    curr_edg_idx = curr_edg_idx + 1;
        
    % Compute new edge
    if curr_edg_idx < 1 + size(edg_list,1)
        
        nxt_edg = edg_list(curr_edg_idx,:);
        
        if ~ismember(nxt_edg,proc_edg_list,'rows')
            
            curr_edg = nxt_edg;
            
        end
        
    else
        
        curr_edg = [];
        
    end
    
end

fprintf('Mesh convex hull computed in %ds.\n',toc);


end % mesh_convex_hull


function [nxt_vtc] = find_nxt_vertex(edg, V, nb_vtx, epsilon)
% find_nxt_vertex : function to find the next vertices in the algorithm
% given a current edge. These candidate new vertices are the ones which
% build a triangle which has all the other vertices of the point set on one
% same unique side.


nxt_vtc = [];

% Candidate triangles
idx_vect = setdiff(1:nb_vtx,edg);
cnd_tgl = cat(2,repmat(edg,[nb_vtx-2,1]),idx_vect');
G = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(cnd_tgl,2),'un',0));

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