% test build_triangulation_from_edge_list

clear all, close all, clc;

addpath('../src');
addpath('../data/');


filenames = {'tetrahedron';...
             'cube';...
             'octahedron';...
             'icosahedron';...
             'dodecahedron';...
             'dodecahedron2';...
             'disk';...
             'torus_light';...
             'torus';...
             'geoid_lvl_16';...
             'meshed_mtlb_logo';...
             'kitten';...
             'Gargoyle_3k';...
             'Gargoyle_5k';...
             'Armadillo_10k';...             
             };

filename = strcat(cell2mat(filenames(8,1)),'.mat');         
load(filename);

% Randomly mess up the edge set
E = query_edges_list(T);
new_idx = randperm(size(E,1));
E = E(new_idx,:);
E = fliplr(E);

clear T;

% Build the mesh
T = build_triangulation_from_edge_list(E);
plot_mesh(V,T);