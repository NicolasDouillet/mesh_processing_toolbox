function tgl_id_list = find_triangle_sets_from_vertex_list(T, vtx_id)
%% find_triangle_sets_from_vertex_list : function to compute the index
% list of triangles containing the vertex indices listed in cell_vtx_id.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
% Input arguments
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3].
%       [|  |  | ]
%
% - vtx_id : positive integer row vector, the vertex indices list.
%
%
% Output argument
%
% - tgl_id_list : positive integer row vector, the triangle indices list.


%% Body
% tic;
tgl_id_list = cellfun(@(i) find(sum(ismember(T,i),2))',num2cell(vtx_id,2),'un',0);
% fprintf('find_triangle_sets_from_vertex_list request executed in %d seconds.\n',toc);


end % find_triangle_sets_from_vertex_list