function bbox = mesh_bounding_box(V)
%% mesh_bounding_box : function to compute the bounding box of the mesh.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input argument
%        
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%%% Output argument
%
% - bbox : real row vector double, the bounding box, size(bbox) = [1,6],
%          bbox = [xmin xmax ymin ymax zmin zmax].


%% Body
tic;

x_bounds = bounds(V(:,1));
y_bounds = bounds(V(:,2));
z_bounds = bounds(V(:,3));

bbox = [x_bounds(1) x_bounds(2) y_bounds(1) y_bounds(2) z_bounds(1) z_bounds(2)];
fprintf('Mesh bounding box computed in %d seconds.\n',toc);


end % mesh_bounding_box