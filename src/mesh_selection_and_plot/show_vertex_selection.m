function [] = show_vertex_selection(V, T, V_subset_id)
%% show_vertex_selection : function to highlight a
% selection of vertices on the mesh.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], double matrix, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
% - V_subset : positive integer row vector, the index list of the selected triangles.


%% Body
if nargin > 2        
    
    if V_subset_id > 0 && max(V_subset_id) < 1+size(V,1)
        
        V_subset = V(V_subset_id,:);
    
    else
       
        error('One or more indices submitted  in V_subset_id are out of the range |[1; %d]|.',size(V,1));
        
    end
    
else
        
    V_subset = V;
    
end

plot_mesh(V,T);
plot3(V_subset(:,1),V_subset(:,2),V_subset(:,3),'ro','Markersize',4,'Linewidth',4), hold on;


end % show_vertex_selection