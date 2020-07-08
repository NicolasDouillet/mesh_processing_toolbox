function [] = plot_mesh(V, T)
%% plot_mesh : function to display the mesh in a Matlab (R) figure.
%
% Author & support : nicolas.douillet (at) free.fr, 2020.
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


%% Body
tic;
h = figure;
set(h,'Position',get(0,'ScreenSize'));
set(gcf,'Color',[0 0 0]);

trisurf(T,V(:,1),V(:,2),V(:,3)), shading faceted, hold on; % ,'FaceColor',[0 1 1]
colormap([0 1 1]);        

xlabel('X'), ylabel('Y'), zlabel('Z');
axis equal;
ax = gca;
ax.Clipping = 'off';

set(gca, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], 'ZColor', [1 1 1]);

fprintf('Mesh with %d vertices and %d triangles displayed in %d seconds.\n',size(V,1),size(T,1),toc);


end % plot_mesh