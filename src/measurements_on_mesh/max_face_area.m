function maxfa = max_face_area(V, T)
%% max_face_area : function to compute the maximum area of the mesh (T) faces, in square graphic unit.
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
%%% Output arguments
%
% - maxfa : positive real scalar double, the maximum face area.


%% Body
tgl_area = cellfun(@(r1,r2,r3) 0.5*sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                               num2cell(V(T(:,2),:)-V(T(:,1),:),2),num2cell(V(T(:,3),:),2),...
                               num2cell(V(T(:,1),:),2),'un',0);
                                     
maxfa = max([tgl_area{:}]);


end % max_face_area