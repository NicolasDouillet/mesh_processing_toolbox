function [bboxe] = compute_mesh_bounding_boxe(V)
%% compute_mesh_bounding_boxe : function to compute the bounding boxe of the mesh.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
% Input argument
%        
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
% Output argument
%
% - bboxe : real row vector double, the bounding boxe, size(bboxe) = [1,6],
%           bboxe = [xmin xmax ymin ymax zmin zmax].


%% Body
tic;

xmin = min(V(:,1));
xmax = max(V(:,1));
ymin = min(V(:,2));
ymax = max(V(:,2));
zmin = min(V(:,3));
zmax = max(V(:,3));

bboxe = [xmin xmax ymin ymax zmin zmax];
fprintf('Mesh bounding boxe computed in %d seconds.',toc);


end % compute_mesh_bounding_boxe