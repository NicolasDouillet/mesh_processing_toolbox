function mael = max_edge_length(V, T)
%% max_edge_length : function to compute the maximum length of the mesh (T) edges.
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
% - mael : positive real scalar double, the maximum edge length.


%% Body
E = query_edg_list(T);
E = unique(sort(E,2),'rows');
mael = max(sqrt(sum((V(E(:,2),:)-V(E(:,1),:)).^2,2)));


end % max_edge_length