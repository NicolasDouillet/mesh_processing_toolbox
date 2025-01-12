function [] = show_mesh_curvature(V, T, C)
%% show_mesh_curvature : function to colorize the mesh curvature (C) on it (T).
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
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3]. Mandatory.
%       [|  |  | ]
%
% - C : cell array of triangle sets (positive integer matrices double), the component array. Mandatory.


%% Body
h = figure;
% set(h,'Position',get(0,'ScreenSize'));
set(gcf,'Color',[0 0 0]);

trisurf(T,V(:,1),V(:,2),V(:,3),C); hold on;
shading interp;
colormap('jet'); % 'hsv'

xlabel('X'), ylabel('Y'), zlabel('Z');
axis equal;
set(gca, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], 'ZColor', [1 1 1]);

ax = gca;
ax.Clipping = 'off';

% view(0,0);
colorbar('Color',[1 1 1]);


end % show_mesh_curvature