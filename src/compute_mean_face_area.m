function mfa = compute_mean_face_area(V, T)
%
% Author & support : nicolas.douillet (at) free.fr, 2023.
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
% Output arguments
%
% - mf, positive real scalar double, the mean face area.


% compute_component_mean_face_area
tgl_area = cellfun(@(r1,r2,r3) sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                       num2cell(V(T(:,2),:)-V(T(:,1),:),2),num2cell(V(T(:,3),:),2),...
                       num2cell(V(T(:,1),:),2),'un',0);
                      
                   
mesh_area = 0.5*sum([tgl_area{:}]);

mfa = mesh_area / size(T,1);


end % compute_mean_face_area