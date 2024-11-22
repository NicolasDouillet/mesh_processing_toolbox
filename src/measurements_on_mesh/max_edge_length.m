function mael = max_edge_length(V, T)
%% max_edge_length : function to compute the maximum length of the mesh (T) edges.
%
%%% Author : nicolas.douillet (at) free.fr, 2024.
%
%
%%% Input arguments
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
%%% Output argument
%
% - mael : positive real scalar double, the maximum edge length.


%% Body
E = query_edges_list(T);
E = unique(sort(E,2),'rows');
mael = max(sqrt(sum((V(E(:,2),:)-V(E(:,1),:)).^2,2)));


end % max_edge_length