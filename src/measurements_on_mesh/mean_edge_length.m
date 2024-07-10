function mel = mean_edge_length(V, T)
%% mean_edge_length : function to compute the average length of the mesh edges.
%
% Author : nicolas.douillet (at) free.fr, 2024.
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
% Output arguments
%
% - mel, positive real scalar double, the mean edge length.


%% Body
E = query_edges_list(T);
E = unique(sort(E,2),'rows');
mel = mean(vecnorm((V(E(:,2),:)-V(E(:,1),:))',2));


end % mean_edge_length