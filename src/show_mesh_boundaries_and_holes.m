function [] = show_mesh_boundaries_and_holes(V, T)
%% show_mesh_boundaries_and_holes : function to highlight holes in the mesh.
%
% About : display holes and boundary without identifying them, and based
% and non shared edges detection.
%
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
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
raw_edges_list = query_edges_list(T);
[~,~,iu] = unique(sort(raw_edges_list,2),'rows'); % unique(raw_edges_list,'rows');

% Unique edges only, even in mirror
[i3,i4] = histc(iu,unique(iu));
lone_edges_idx_vect = i3(i4) == 1;
lone_edges_list = raw_edges_list(lone_edges_idx_vect,:);

plot_mesh(V,T);

cellfun(@(r) line([V(r(1),1) V(r(2),1)],...
                  [V(r(1),2) V(r(2),2)],...
                  [V(r(1),3) V(r(2),3)],'Color',[1 0 0],'Linewidth',2),...
                  num2cell(lone_edges_list,2),'un',0);


end % show_mesh_boundaries_and_holes