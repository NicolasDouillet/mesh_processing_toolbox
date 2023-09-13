function [V, T] = unite_meshes(V1, V2, T1, T2)
%% unite_meshes function to perform the union of two meshes.
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2023.
%
%
% Input arguments
%        
%        [ |  |  |]
% - V1 = [X1 Y1 Z1], real matrix double, the first input point set, size(V1) = [nb_vertices_1,3].
%        [ |  |  |]
%
%        [ |   |   | ]
% - T1 = [i11 i12 i13], positive integer matrix double, the first input triangulation, size(T1) = [nb_triangles_1,3].
%        [ |   |   | ]
%        
%        [ |  |  |]
% - V2 = [X2 Y2 Z2], real matrix double, the second input point set, size(V2) = [nb_vertices_2,3].
%        [ |  |  |]
%
%        [ |   |   | ]
% - T2 = [i21 i22 i23], positive integer matrix double, the second input triangulation, size(T2) = [nb_triangles_2,3].
%        [ |   |   | ]
%
%
% Output arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the output point set, size(V) = [nb_vertices,3],
%       [| | |]
%
%       with nb_vertices = nb_vertices_1 + nb_vertices_2.
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the output triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%       with nb_triangles = nb_triangles_1 + nb_triangles_2.


%% Body
tic;
Vs = cat(1,V1,V2);
T2 = T2 + size(V1,1);
Ts = cat(1,T1,T2);
Tm = remove_duplicated_triangles(Ts);
[V,T] = remove_duplicated_vertices(Vs,Tm);
fprintf('Mesh union performed in %d seconds.\n',toc);


end % unite_meshes