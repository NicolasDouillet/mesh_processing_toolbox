function T = quad2trimesh(Q)
%% quadmesh2trimesh : function to convert a quadrangular mesh
% into a triangular mesh.
%
% Assumption : % V1, V2, V3, V4 vertices of each quadrangle are assumed to be coplanar.
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2023.
%
%
% Input argument
%
%       [|  |  |  | ]
% - Q : [i1 i2 i3 i4], positive integer matrix, the quadrangles list, size(Q) = [nb_quadrangles,4]
%       [|  |  |  | ]
%
%
% Output argument
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3],
%       [|  |  | ]
%
%       with nb_triangles = 2*nb_quadrangles.
%


%% Body
% tic;
T = cat(1,Q(:,1:3),cat(2,Q(:,1),Q(:,3),Q(:,4)));
% fprintf('%d quadrangular faces converted into %d triangular faces in %d seconds.\n',size(Q,1),size(T,1),toc);


end % quad2trimesh