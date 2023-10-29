function [V_out, T_out] = split_edge(V_in, T_in, E_set)
%% split_edge : function to split edges. 
%
% Author & support : nicolas.douillet (at) free.fr, 2021-2023.
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
%           [|   |]      
% - E_set = [e1 e2], positive integer matrix double, the set of the edges to split. size(E_set) = [nb_edges_to_split, 2].
%           [|   |]
%
%
% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           where nb_output_vertices = nb_input_vertices + number of edges in E_set.
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]
%
%           with nb_output_triangles = nb_input_triangles + number of edges in E_set.


%% Body

% Create new vertices
new_vtx_coord = 0.5 * (V_in(E_set(:,1),:) + V_in(E_set(:,2),:));
[V_out,new_vtx_id] = add_vertices(new_vtx_coord,V_in);

% Create new triangles
tgl_idx_list = cell2mat(find_triangle_indices_from_edges_list(T_in,E_set));

mask = all(bsxfun(@ne,T_in(tgl_idx_list,:),permute(E_set,[1 3 2])),3);
At = T_in(tgl_idx_list,:).';
summit_vtx_idx_list = reshape(At(mask.'),[],size(T_in(tgl_idx_list,:),1)).';

new_tgl_set1 = cat(2,summit_vtx_idx_list,E_set(:,1),new_vtx_id');
new_tgl_set2 = cat(2,summit_vtx_idx_list,new_vtx_id',E_set(:,2));

% Add new triangles
T_out = add_triangles(new_tgl_set1,T_in,size(V_out,1));
T_out = add_triangles(new_tgl_set2,T_out,size(V_out,1));

% Remove old triangles
T_out  = remove_triangles(T_out,tgl_idx_list,'indices');


end % split_edge