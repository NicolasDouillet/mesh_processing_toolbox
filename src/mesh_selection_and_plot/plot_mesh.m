function [] = plot_mesh(V, T)
%% plot_mesh : function to display the mesh in a Matlab (R) figure.
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


%% Body

h = figure;
% set(h,'Position',get(0,'ScreenSize'));
set(gcf,'Color',[0 0 0]);


if isa(T,'double')
    
    if size(T,2) == 3
        
        trisurf(T,V(:,1),V(:,2),V(:,3)), shading faceted, hold on; % ,'FaceColor',[0 1 1]
        colormap([0 1 1]);
        
    elseif size(T,2) > 3                
        
        for n = 1:size(T,1)
            
            fill3(V(T(n,:),1),V(T(n,:),2),V(T(n,:),3),[0 1 1]), hold on;
            
        end
        
    end
    
elseif iscell(T)
    
    for n = 1:size(T,1)
        
        T_cell = cell2mat(T(n,1));
        fill3(V(T_cell,1),V(T_cell,2),V(T_cell,3),[0 1 1]), hold on;
        
    end
    
end



xlabel('X'), ylabel('Y'), zlabel('Z');
axis equal;
ax = gca;
ax.Clipping = 'off';

set(gca, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], 'ZColor', [1 1 1]);

% fprintf('Mesh with %d vertices and %d triangles displayed in %d seconds.\n',numel(unique(T(:))),size(T,1),toc);


end % plot_mesh