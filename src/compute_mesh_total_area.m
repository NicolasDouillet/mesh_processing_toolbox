function mesh_area = compute_mesh_total_area(V, T)
%% compute_mesh_total_area : function to compute the area of the whole mesh, in area unit.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
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
%
% Output argument
%
% - mesh_area : real scalar double, the area of the mesh, in area unit.


%% Body
tic;

tgl_area = cellfun(@(r1,r2,r3) sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                   num2cell(V(T(:,2),:)-V(T(:,1),:),2),num2cell(V(T(:,3),:),2),...
                   num2cell(V(T(:,1),:),2),'un',0);
                        
mesh_area = 0.5*sum([tgl_area{:}]);

fprintf('Mesh total area computed in %d seconds.\n',toc);


end % compute_mesh_total_area