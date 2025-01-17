% test vertex_decimation

clc;

addpath(genpath('../../src'));
addpath('../../data');


load('kitten.mat');
plot_mesh(V,T);

vtx_id2suppr = 1:200;
[V,T] = vertex_decimation(V,T,vtx_id2suppr);
plot_mesh(V,T);