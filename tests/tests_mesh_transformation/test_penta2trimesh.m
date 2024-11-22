% Test penta2trimesh

clc;

addpath(genpath('../../src'));
addpath('../../data');


load('icosahedron.mat');
plot_mesh(V,T);

[V_dual,T_dual] = dual_of_trimesh(V,T);

T2 = penta2trimesh(cell2mat(T_dual));
plot_mesh(V_dual,T2);
shading faceted;