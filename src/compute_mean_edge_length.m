function mel = compute_mean_edge_length(V, T)
%
% Author & support : nicolas.douillet (at) free.fr, 2023.
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


% compute_component_mean_edge_length

E = query_edges_list(T);

% Remove duplicated edges
E = unique(sort(E,2),'rows');

mel = mean(sqrt(sum((V(E(:,2),:)- V(E(:,1),:)).^2,2)),1);


end % compute_mean_edge_length