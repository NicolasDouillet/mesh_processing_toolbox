function [V_out, T_out, VTEXT_out, TF_out] = split_edge_with_texture(V_in, T_in, E_set, edg_id, VTEXT_in, TF_in)
%% split_edge : function to split edges with texture.
%
% Author : nicolas.douillet (at) free.fr, 2021-2024.
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
% - edg_id : positive integer vector double, the indices of the edges to split in E_set.
%
% - VTEXT_in : input vertex texture.
%
% - TF_in :    input triangle texture.
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
%
% - VTEXT_out : output vertex texture.
%
% - TF_out :    output triangle texture.


%% Body

% Create new vertices
new_vtx_coord = 0.5 * (V_in(E_set(:,1),:) + V_in(E_set(:,2),:));
[V_out,new_vtx_id] = add_vertices(new_vtx_coord,V_in);

E_txt_set = query_edges_list(TF_in,'raw');
E_txt_set = E_txt_set(edg_id,:);

% Create corresponding vertex textures if nargin > 3
new_vtx_txt = 0.5 * (VTEXT_in(E_txt_set(:,1),:) + VTEXT_in(E_txt_set(:,2),:));
VTEXT_out = cat(1,VTEXT_in,new_vtx_txt);
new_vtxt_id = (1+size(VTEXT_in,1)):size(VTEXT_in,1)+size(new_vtx_txt,1);

% Create new triangles
tgl_id_list = cell2mat(find_triangle_indices_from_edges_list(T_in,E_set));

mask = all(bsxfun(@ne,T_in(tgl_id_list,:),permute(E_set,[1 3 2])),3);
At = T_in(tgl_id_list,:).';
summit_vtx_id_list = reshape(At(mask.'),[],size(T_in(tgl_id_list,:),1)).';

new_tgl_set1 = cat(2,summit_vtx_id_list,E_set(:,1),new_vtx_id');
new_tgl_set2 = cat(2,summit_vtx_id_list,new_vtx_id',E_set(:,2));

% Add new triangles
T_out = add_triangles(new_tgl_set1,T_in);
T_out = add_triangles(new_tgl_set2,T_out);

% Create new textures
tgl_txt_id_list = cell2mat(find_triangle_indices_from_edges_list(TF_in,E_txt_set));

mask = all(bsxfun(@ne,TF_in(tgl_txt_id_list,:),permute(E_txt_set,[1 3 2])),3);
At = TF_in(tgl_txt_id_list,:).';
summit_vtx_txt_id_list = reshape(At(mask.'),[],size(TF_in(tgl_txt_id_list,:),1)).';

new_tgl_txt_set1 = cat(2,summit_vtx_txt_id_list,E_txt_set(:,1),new_vtxt_id');
new_tgl_txt_set2 = cat(2,summit_vtx_txt_id_list,new_vtxt_id',E_txt_set(:,2));

% Add new textures
TF_out = add_triangles(new_tgl_txt_set1,TF_in);
TF_out = add_triangles(new_tgl_txt_set2,TF_out);

% Remove old triangles
T_out  = remove_triangles(T_out,tgl_id_list,'indices');
TF_out = remove_triangles(TF_out,tgl_txt_id_list,'indices');


end % split_edge