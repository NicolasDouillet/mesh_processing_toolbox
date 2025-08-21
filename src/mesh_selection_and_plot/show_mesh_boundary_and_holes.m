function [] = show_mesh_boundary_and_holes(V, T, boundaries, hole_ids)
%% show_mesh_boundary_and_holes : function to show and highlight
% boundary and holes in the mesh (T) with different colors.
%
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
% - boundaries : cell array of positive integer row vectors double, size(boundaries) = [nb_holes,1]. Mandatory.
%
% - hole_ids : positive integer vector double, vector of the holes ids. Optional.


%% Input parsing
if nargin < 4
   
    hole_ids = 1:size(boundaries,1);
    
end


%% Body
boundaries = boundaries(hole_ids,1);
plot_mesh(V,T);

colorstring = 'myrgbwk';

for n = 1:size(boundaries,1)
    
    boundary = cell2mat(boundaries(n,1));
    
    X_bound = V(boundary,1);
    Y_bound = V(boundary,2);
    Z_bound = V(boundary,3);
    
    line(cat(1,X_bound,X_bound(1,:)),cat(1,Y_bound,Y_bound(1,:)),cat(1,Z_bound,Z_bound(1,:)),...
         'Color',colorstring(1,1+mod(n,numel(colorstring))),'Linewidth',3), hold on;
    
end


end % show_mesh_boundary_and_holes