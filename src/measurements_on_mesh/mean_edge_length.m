function mel = mean_edge_length(V, T)
%% mean_edge_length : function to compute the average length of the mesh (T) edges.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.
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
%%% Output arguments
%
% - mel, positive real scalar double, the mean edge length.


%% Body
E = query_edg_list(T,'sorted');
mel = mean(sqrt(sum((V(E(:,2),:)-V(E(:,1),:)).^2,2)));


end % mean_edge_length