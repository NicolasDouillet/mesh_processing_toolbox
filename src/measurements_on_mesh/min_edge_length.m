function miel = min_edge_length(V, T)
%% min_edge_length : function to compute the minimum length of the mesh edges.
%
% Author : nicolas.douillet9 (at) gmail.com, 2024.
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
% - miel, positive real scalar double, the minimum edge length.


%% Body
E = query_edges_list(T);
E = unique(sort(E,2),'rows');
miel = min(sqrt(sum((V(E(:,2),:)-V(E(:,1),:)).^2,2)));


end % min_edge_length