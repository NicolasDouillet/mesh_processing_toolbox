% Test hexa2trimesh

clc;

addpath(genpath('../../src'));
addpath('../../data');


load('torus_light.mat'); % dual known to be an hexagonal mesh
plot_mesh(V,T);

[V_dual,T_dual] = dual_of_trimesh(V,T);

T2 = hexa2trimesh(cell2mat(T_dual));
plot_mesh(V_dual,T2);
shading flat;