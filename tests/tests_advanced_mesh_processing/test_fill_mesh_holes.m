% test fill_mesh_holes

clc;

addpath(genpath('../../src'));
addpath('../../data');


filenames = {'kitten_holed';...
             'kitten_big_hole';...
             'kitten_components';...
             'meshed_mtlb_logo'};

filename = strcat(cell2mat(filenames(3,1)),'.mat');         
load(filename);


% % If necessary (presence of non manifold vertices, 'kitten_holed.mat' for instance)
% [V,T] = remove_non_manifold_vertices(V,T);
%
% % If necessary (new small components created after remove_non_manifold_vertices)
% [cc_nb,C] = segment_connected_components(T,'explicit');
%
% if cc_nb > 1
%
%     pct2rm = 3;
%     [T,V] = remove_small_components(C,pct2rm,V,true); % optional but better
%
% end

boundary = mesh_boundary_and_holes(T);

max_perim_sz = 200; % fill every holes except the largest ones on 'kitten_big_hole.mat'
T = fill_mesh_holes(V,T,boundary,max_perim_sz);
plot_mesh(V,T);