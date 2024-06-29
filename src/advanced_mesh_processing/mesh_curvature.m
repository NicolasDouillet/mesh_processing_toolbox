function curvature = mesh_curvature(V, T, N, ngb_degre, curv_type)
%% mesh_curvature : function to compute curvature on every vertex of the mesh.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
% 
% Info / about : homemade temporary version of a curvature computation algorithm.
% Is mostly relevant for and appliable to regular meshes (faces have approximately
% all the same size, and vertices the same valence).
% 
%  
% Input arguments                                                        
%        
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%       [ |  |  |]
% - N : [Nx Ny Nz], real matrix double, the vertex normalized normal vectors, size(N) = [nb_vertices,3].
%       [ |  |  |]
%
% - ngb_degre : positive integer scalar double in the range |[1; 6]|, the neighbor degre. Default value is 1.
%
% - curv_type : character string in the set : {'gaussian','normal','absolute','GAUSSIAN','NORMAL','ABSOLUTE'}
%
%
% Output argument
%
% - curvature : real column vector double, the vertex curvature map / field, size(C) = size(V). 


tic;


%% Input parsing and default parameters
if nargin < 5
    
    curv_type = 'mean';
    
    if nargin < 4
        
        ngb_degre = 2;
        
    end
    
end


%% Body
cell_vtx_idx = num2cell((1:size(V,1))',2);
vtx_ngb_idx_list = find_every_vertices_neighbor_indices(T,ngb_degre,size(V,1));
vect2ngb_cell = cellfun(@(c1,c2) V(c1,:)-repmat(V(c2,:),[numel(c1),1]),vtx_ngb_idx_list,cell_vtx_idx,'un',0);


if strcmpi(curv_type,'mean')
    
curvature = cell2mat(cellfun(@(c1,c2) mean(abs(dot(c1,repmat(N(c2,:),[size(c1,1),1]),2)),1),...
                     vect2ngb_cell,cell_vtx_idx,'un',0));
                 
elseif strcmpi(curv_type,'max')
    
    curvature = cell2mat(cellfun(@(c1,c2) max(abs(dot(c1,repmat(N(c2,:),[size(c1,1),1]),2))),...
                         vect2ngb_cell,cell_vtx_idx,'un',0));
    
end

fprintf('%s curvature computed in %d seconds.\n',curv_type,toc);


end % mesh_curvature