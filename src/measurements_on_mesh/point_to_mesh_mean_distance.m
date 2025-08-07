function pt2mesh_mean_dst = point_to_mesh_mean_distance(M, V, T)
%% pt2mesh_mean_dst : function to compute the mean distance of a given
% M point to the mesh T.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2023-2025.
%
%
%%% Input arguments
%
% - M = [Mx My Mz], real row vector double, the point  to test. Size(M) = [1,3]. Mandatory.
%
%       [| | |]
% - V = [X Y Z], real matrix double, the input point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the input triangulation, size(T) = [nb_triangles,3]. Mandatory.
%       [ |  |  |]
%
%
%%% Output argument
%
% - pt2mesh_mean_dst : real positive scalar double, the mean distance from the point to the mesh.


%% Body
dst_vect = zeros(1,height(T)); 

for k = 1:height(T)
    
    
    dst_vect(k) = point_to_plane_distance(M,cross(V(T(k,2),:)-V(T(k,1),:),V(T(k,3),:)-V(T(k,1),:)),V(T(k,1),:));

end

pt2mesh_mean_dst = mean(dst_vect,2);



end % point_to_mesh_mean_distance