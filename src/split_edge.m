function [V_out, T_out] = split_edge(V_in, T_in, E_set)
%
% Author & support : nicolas.douillet (at) free.fr, 2021-2023.



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
T_out  = remove_triangles(tgl_idx_list,T_out,'indices');


end % split_edge