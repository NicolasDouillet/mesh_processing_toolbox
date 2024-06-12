function [] = show_mesh_components(V, C)
%% show_mesh_components : function to color individually and specifically
% each component of the mesh with a different color.
%
% Author : nicolas.douillet @free.fr (at) free.fr, 2020-2024.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
% - C : cell array of triangle sets (positive integer matrices double), the component array.



%% Body
h = figure;
% set(h,'Position',get(0,'ScreenSize'));
set(gcf,'Color',[0 0 0]);

colorstring = 'cmygrbw';

for n = 1:size(C,1)
    
    T = cell2mat(C(n,1));    
    trisurf(T,V(:,1),V(:,2),V(:,3),'FaceColor',...
    colorstring(1,mod(n,numel(colorstring)))); hold on;            
    
end

        
xlabel('X'), ylabel('Y'), zlabel('Z');
axis equal;
set(gca, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], 'ZColor', [1 1 1]);

ax = gca;
ax.Clipping = 'off';

view(0,90);


end % show_mesh_components