% test edge_collapse

clc;

addpath(genpath('../src'));
addpath('../data');


load('kitten.mat');
plot_mesh(V,T);

edg_list = query_edges_list(T);
edg2collapse = edg_list(1:500,:);

[V,T] = edge_collapse(V,T,edg2collapse);
plot_mesh(V,T);