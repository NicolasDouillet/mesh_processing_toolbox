function [tgl_idx_list] = find_triangle_sets_from_vertex_list(T, vtx_idx)
%% find_triangle_sets_from_vertex_list : function to compute the index
% list of triangles containing the vertex indices listed in cell_vtx_idx.
%
% Author & support : nicolas.douillet (at) free.fr, 2020.
%
%
% Input arguments
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3].
%       [|  |  | ]
%
% - vtx_idx : positive integer row vector, the vertex indices list.
%
%
% Output argument
%
% - tgl_idx_list : positive integer row vector, the triangle indices list.


%% Body
% tic;
tgl_idx_list = cellfun(@(i) find(sum(ismember(T,i),2))',num2cell(vtx_idx,2),'UniformOutput',false);
% fprintf('find_triangle_sets_from_vertex_list request executed in %d seconds.\n',toc);


end % find_triangle_sets_from_vertex_list