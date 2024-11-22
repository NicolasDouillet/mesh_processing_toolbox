function T = penta2trimesh(P)
%% penta2trimesh : function to convert a pentagonal mesh into a triangular mesh.
%
% Assumption : % V1, V2, V3, V4, V5, and V6 vertices of each pentagon are assumed to be coplanar.
%
%%% Author : nicolas.douillet (at) free.fr, 2023-2024.
%
%
%%% Input argument
%
%       [|  |  |  |  | ]
% - P : [i1 i2 i3 i4 i5], positive integer matrix, the pentagons list, size(P) = [nb_pentagons,5]
%       [|  |  |  |  [ ]
%
%
%%% Output argument
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3],
%       [|  |  | ]
%
%       with nb_triangles = 3*nb_pentagons.
%


%% Body
% tic;
T = cat(1,P(:,1:3),P(:,3:5),P(:,1:2:5));
% fprintf('%d pentagonal faces converted into %d triangular faces in %d seconds.\n',size(P,1),size(T,1),toc);


end % penta2trimesh