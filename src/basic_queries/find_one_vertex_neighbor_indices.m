function vtx_ngb_id = find_one_vertex_neighbor_indices(T, vtx_id)
%% find_one_vertex_neighbor_indices : function to find one vertex neighbor indices.
%
% Author : nicolas.douillet (at) free.fr, 2021-2024.
%
%
% Input arguments
%
%          [ |  |  |]
% - T_in = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%          [ |  |  |]
%     
% - vtx_id : positive integer scalar, the vertex index. 
%
%
% Output arguments
%
% - vtx_ngb_id : positive integer matrix double, the neighor vertex indices, size(vtx_ngb_id) = [1,number_of_neighbor_vertices].


%% Body
vtx_ngb_id = setdiff(T(any(T == vtx_id,2),:),vtx_id)';


end % find_one_vertex_neighbor_indices