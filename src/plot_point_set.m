function [] = plot_point_set(V, marker, color, markersize)
%% plot_point_set : function to plot the point set vertices in a Matlab (R) figure.
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
% - marker : character in the set {'o','+','*','.','x','s','d','^','v','>','<','p','h'}. For further details see Line Spec in
%            plot function documentation (doc plot).
%
% - color : character in the set {'y','m','c','r','g','b','w','k'}. For further details see Line Spec in
%           plot function documentation (doc plot).
%
% - markersize : positive integer scalar double, the size of markers.
%                Default value is 6.


%% Body
if nargin < 2
   
    % Default parameter values
    marker = '.';
    color = 'y';
    markersize = 6;
    
end

h = figure;
set(h,'Position',get(0,'ScreenSize'));
set(gcf,'Color',[0 0 0]);

plot3(V(:,1),V(:,2),V(:,3),strcat(color,marker),'MarkerSize',markersize,'MarkerEdgeColor',color,'MarkerFaceColor',color), hold on;
xlabel('X'), ylabel('Y'), zlabel('Z');
axis equal;
set(gca, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], 'ZColor', [1 1 1]);


end % plot_point_set