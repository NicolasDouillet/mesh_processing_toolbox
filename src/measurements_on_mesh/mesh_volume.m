function mesh_volume = mesh_volume(V, T)
%% mesh_volume : function to compute the volume of the mesh T.
%
% Requirements : 2D-manifold closed watertight surface,
% without duplicated or self intersecting triangles.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3]. Mandatory.
%       [ |  |  |]
%
%
%%% Output argument
%
% - mesh_volume : positive real double scalar, the mesh volume.


%% Body
tic;

mesh_volume = abs(sum(cell2mat(cellfun(@(r)...
              dot(cross(V(r(1,1),:),V(r(1,2),:),2),V(r(1,3),:),2),...
              num2cell(T,2),'un',0))))/6;
          
fprintf('Mesh volume computed in %d seconds.\n',toc);


end % mesh_volume