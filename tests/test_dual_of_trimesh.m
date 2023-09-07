% Test dual_of_trimesh


clear all, close all, clc;

addpath('../src');
addpath('../data');

            
load('kitten.mat'); % tetrahedron % cube % octahedron % icosahedron % dodecahedron2 % disk % torus_light

plot_mesh(V,T);

[V_dual,T_dual] = dual_of_trimesh(V,T);
plot_mesh(V_dual,T_dual);       