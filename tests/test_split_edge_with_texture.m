% test split_edge_with_texture

clc;

addpath(genpath('../src'));
addpath('../data');


load('mesh_piece_with_texture.mat');

boundary = select_mesh_boundary_and_holes(V,T);
boundary_edges = cell2mat(boundary(1));
boundary_edges = reshape(circshift(repelem(boundary_edges,2),1)',[2,numel(boundary_edges)])';

E = query_edges_list(T,'raw');
edg_idx = 1:size(E,1); % select all edges of the boundary, this is one example, but we could do something else
tgl_idx_list = find_triangle_indices_from_edges_list(T,E);
nb_tgl_vect = cell2mat(cellfun(@numel,tgl_idx_list,'UniformOutput',false));
edg_idx = edg_idx(nb_tgl_vect < 2);


% E = query_edges_list(T,'raw');
% % Select edges with length > mean edge length
% edglength = sqrt(sum((V(E(:,1),:) - V(E(:,2),:)).^2,2));
% thres = 0.1; % 1.33
% meanedglength = thres*mean(edglength,1);
% edg_idx2 = edglength > meanedglength
% E = E(edg_idx2,:);
% 
% % Select corresponding triangles on the boundary
% tgl_idx_list = find_triangle_indices_from_edges_list(T,E);
% nb_tgl_vect2 = cell2mat(cellfun(@numel,tgl_idx_list,'UniformOutput',false));
% boundary_edge_set = E(nb_tgl_vect2 < 2,:); % non shared edges


% Slip every edges on the boundary
[V_out,T_out,UV_out,TF_out] = split_edge_with_texture(V,T,boundary_edges,edg_idx,UV,TF); % UV : vertex texture; TF triangle texture


% No textured mesh display available in Matlab core yet
plot_mesh(V_out,T_out);

