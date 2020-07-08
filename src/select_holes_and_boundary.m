function [boundaries] = select_holes_and_boundary(V, T)
%% select_holes_and_boundary : function to select and display
% holes and boundary of the mesh.
%
% About : holes and boundary are identified and segmented
% (detect_mesh_holes_and_boundary), and their displays use different colors.
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
%
%
% Output argument
%
% - boundaries : cell array of positive integer row vectors double, size(boundaries) = [nb_holes,1].


%% Body
boundaries = detect_mesh_holes_and_boundary(T);
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


end % select_holes_and_boundary