function pt2mesh_mean_dst = point_to_mesh_mean_distance(M, V, T)
%
% Author & support : nicolas.douillet (at) free.fr, 2023.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the input point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the input triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]


% with point to plane distance on every plane defined by the triangles of
% the set


dst_vect = zeros(1,size(T,1)); 

for k = 1:size(T,1)
    
    
    dst_vect(k) = point_to_plane_distance(M,cross(V(T(k,2),:)-V(T(k,1),:),V(T(k,3),:)-V(T(k,1),:)),V(T(k,1),:))

end

pt2mesh_mean_dst = mean(dst_vect,2);



end % point_to_mesh_mean_distance