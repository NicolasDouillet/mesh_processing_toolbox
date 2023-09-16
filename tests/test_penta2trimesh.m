% Test penta2trimesh


clear all, close all, clc;

addpath('../src');
addpath('../data');


load('icosahedron.mat');
[V_dual,T_dual] = dual_of_trimesh(V,T);
plot_mesh(V_dual,T_dual);

T2 = penta2trimesh(cell2mat(T_dual));
plot_mesh(V_dual,T2);