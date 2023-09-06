function [V_out, T_out, VTEXT_out, TF_out] = split_edge_with_texture(V_in, T_in, E_set, edg_idx, VTEXT_in, TF_in)


% E_set : border edges only
%
% VTEXT_in : vertex textures in
%
% TF_in : triangle textures in


% Create new vertices
new_vtx_coord = 0.5 * (V_in(E_set(:,1),:) + V_in(E_set(:,2),:));
[V_out,new_vtx_id] = add_vertices(new_vtx_coord,V_in);

E_txt_set = query_edges_list(TF_in,'raw');
E_txt_set = E_txt_set(edg_idx,:);

% Create corresponding vertex textures if nargin > 3
new_vtx_txt = 0.5 * (VTEXT_in(E_txt_set(:,1),:) + VTEXT_in(E_txt_set(:,2),:));
VTEXT_out = cat(1,VTEXT_in,new_vtx_txt);
new_vtxt_id = (1+size(VTEXT_in,1)):size(VTEXT_in,1)+size(new_vtx_txt,1);

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

% Create new textures
tgl_txt_idx_list = cell2mat(find_triangle_indices_from_edges_list(TF_in,E_txt_set));

mask = all(bsxfun(@ne,TF_in(tgl_txt_idx_list,:),permute(E_txt_set,[1 3 2])),3);
At = TF_in(tgl_txt_idx_list,:).';
summit_vtx_txt_idx_list = reshape(At(mask.'),[],size(TF_in(tgl_txt_idx_list,:),1)).';

new_tgl_txt_set1 = cat(2,summit_vtx_txt_idx_list,E_txt_set(:,1),new_vtxt_id');
new_tgl_txt_set2 = cat(2,summit_vtx_txt_idx_list,new_vtxt_id',E_txt_set(:,2));

% Add new textures
TF_out = add_triangles(new_tgl_txt_set1,TF_in,size(VTEXT_out,1));
TF_out = add_triangles(new_tgl_txt_set2,TF_out,size(VTEXT_out,1));

% Remove old triangles
T_out  = remove_triangles(tgl_idx_list,T_out,'indices');
TF_out = remove_triangles(tgl_txt_idx_list,TF_out,'indices'); % textures


end % split_edge