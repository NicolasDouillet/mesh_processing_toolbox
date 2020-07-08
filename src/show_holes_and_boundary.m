function [] = show_holes_and_boundary(V, T)
%% show_holes_and_boundary : function to highlight holes in the mesh.
%
% About : display holes and boundary without identifying them, and based
% and non shared edges detection.
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
raw_edges_list = query_edges_list(T);
[~,~,iu] = unique(sort(raw_edges_list,2),'rows'); % unique(raw_edges_list,'rows');

% Unique edges only, even in mirror
[i3,i4] = histc(iu,unique(iu));
lone_edges_idx_vect = i3(i4) == 1;
lone_edges_list = raw_edges_list(lone_edges_idx_vect,:);

plot_mesh(V,T);

for i = 1:size(lone_edges_list,1)
    
    line([V(lone_edges_list(i,1),1) V(lone_edges_list(i,2),1)],...
        [V(lone_edges_list(i,1),2) V(lone_edges_list(i,2),2)],...
        [V(lone_edges_list(i,1),3) V(lone_edges_list(i,2),3)],'Color',[1 0 0],'Linewidth',2), hold on;
    
end


end % show_holes_and_boundary