% test build_triangulation_from_edge_list

clear all, close all, clc;

addpath('../src');
addpath('../data/');

load('icosahedron.mat'); % geoid_lvl_16

% Randomly mess up the edge set
E = query_edges_list(T)
new_idx = randperm(size(E,1))
E = E(new_idx,:)
E = fliplr(E);

clear T;

% Rebuild the mesh
T = rebuild_triangulation_from_edge_list(E);
plot_mesh(V,T);