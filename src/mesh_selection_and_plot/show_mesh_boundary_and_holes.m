function [] = show_mesh_boundary_and_holes(V, T)
%% show_mesh_boundary_and_holes : function to highlight holes in the mesh (T).
%
%%% About : display holes and boundary without identifying them, and based
% and non shared edges detection.
%
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
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
boundaries = detect_mesh_boundary_and_holes(T);

plot_mesh(V,T);
shading interp;
camlight left;

colorstring = 'wrymgbc';
             
              
for n = 1:size(boundaries,1)
    
    B = cell2mat(boundaries(n,1));    
    line([V(B,1) V(circshift(B,1),1)],[V(B,2) V(circshift(B,1),2)],[V(B,3) V(circshift(B,1),3)],...
         'Color',colorstring(1,1+mod(n,numel(colorstring))),'LineWidth',2); hold on;            
    
end              


end % show_mesh_boundary_and_holes