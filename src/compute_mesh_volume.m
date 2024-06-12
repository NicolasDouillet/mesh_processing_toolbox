function mesh_volume = compute_mesh_volume(V, T)
%% compute_mesh_volume : function to compute the volume of the mesh
% defined by the vertex set V, and the triangle set T.
%
% Requirements : 2D-manifold closed watertight surface,
% without duplicated or self intersecting triangles.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
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
%
% Output argument
%
% - mesh_volume : real double scalar, the mesh volume.


%% Body
tic;

mesh_volume = abs(sum(cell2mat(cellfun(@(r)...
              dot(cross(V(r(1,1),:),V(r(1,2),:),2),V(r(1,3),:),2),...
              num2cell(T,2),'un',0))))/6;
          
fprintf('Mesh volume computed in %d seconds.\n',toc);


end % compute_mesh_volume