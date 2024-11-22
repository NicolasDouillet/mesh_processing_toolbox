function T = hexa2trimesh(P)
%% hexa2trimesh : function to convert a hexagonal mesh into a triangular mesh.
%
% Assumption : % V1, V2, V3, V4, V5, and V6 vertices of each hexagon are assumed to be coplanar.
%
%%% Author : nicolas.douillet (at) free.fr, 2024.
%
%
%%% Input argument
%
%       [|  |  |  |  |  | ]
% - H : [i1 i2 i3 i4 i5 i6], positive integer matrix, the hexagons list, size(P) = [nb_hexagons,6]
%       [|  |  |  |  [  | ]
%
%
%%% Output argument
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3],
%       [|  |  | ]
%
%       with nb_triangles = 4*nb_hexagons.
%


%% Body
% tic;
T = cat(1,P(:,1:3),P(:,3:5),P(:,[1 5 6]),cat(2,P(:,1:2:5)));
% fprintf('%d hexagonal faces converted into %d triangular faces in %d seconds.\n',size(P,1),size(T,1),toc);


end % hexa2trimesh