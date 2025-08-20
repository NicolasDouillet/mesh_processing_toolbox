function miel = min_edge_length(V, T)
%% min_edge_length : function to compute the minimum length of the mesh (T) edges.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2024-2025.
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
%
%
%%% Output argument
%
% - miel : positive real scalar double, the minimum edge length.


%% Body
E = query_edg_list(T,'sorted');
miel = min(sqrt(sum((V(E(:,2),:)-V(E(:,1),:)).^2,2)));


end % min_edge_length