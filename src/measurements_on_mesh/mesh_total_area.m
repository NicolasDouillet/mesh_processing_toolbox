function mesh_area = mesh_total_area(V, T)
%% mesh_total_area : function to compute the area of the whole mesh T, in area unit.
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
%%% Output argument
%
% - mesh_area : positive real scalar double, the area of the mesh, in area unit.


%% Body
tic;

tgl_area = cellfun(@(r1,r2,r3) sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                   num2cell(V(T(:,2),:)-V(T(:,1),:),2),num2cell(V(T(:,3),:),2),...
                   num2cell(V(T(:,1),:),2),'un',0);
                        
mesh_area = 0.5*sum([tgl_area{:}]);

fprintf('Mesh total area computed in %d seconds.\n',toc);


end % mesh_total_area