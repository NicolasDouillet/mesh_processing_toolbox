function [V_out, T_out] = remove_non_manifold_vertices(V_in, T_in)
%% remove_non_manifold_vertices : function to remove
% non manifold vertices from the mesh.
%
% Working principle & criterion : non manifold vertices have at least
% two more linked edges than linked triangles.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3].
%          [ |    |    |  ]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
%
% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           where nb_output_vertices = nb_input_vertices - nb_non_manifold_vertices.
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3],
%           [  |      |      |   ]


%% Body
tic;
vtx_id = (1:size(V_in,1))';
edg_lists = find_edges_from_vertex_list(T_in,vtx_id);

% Nb linked edge per vertex
vtx_ngb_edg_nb = cellfun(@(c) size(c,1),edg_lists);

% Nb linked triangles per vertex
tgl_id_list = find_triangle_sets_from_vertex_list(T_in,vtx_id);
vtx_ngb_tgl_nb = cellfun(@(c) numel(c),tgl_id_list);

nmnfld_vtx_id = find(vtx_ngb_edg_nb > vtx_ngb_tgl_nb+1);
[V_out,T_out] = remove_vertices(nmnfld_vtx_id,V_in,T_in,'indices');

fprintf('%d non manifold vertices removed in %d seconds.\n',size(V_in,1)-size(V_out,1),toc);


end % remove_non_manifold_vertices