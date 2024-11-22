function meanfa = mean_face_area(V, T)
%% mean_face_area : function to compute the average area of the mesh (T) faces, in square graphic unit.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
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
%%% Output arguments
%
% - meanfa : positive real scalar double, the mean face area.


%% Body
tgl_area = cellfun(@(r1,r2,r3) sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                               num2cell(V(T(:,2),:)-V(T(:,1),:),2),num2cell(V(T(:,3),:),2),...
                               num2cell(V(T(:,1),:),2),'un',0);
                                     
mesh_area = 0.5*sum([tgl_area{:}]);
meanfa = mesh_area / size(T,1);


end % mean_face_area