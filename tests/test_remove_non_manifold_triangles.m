% test remove non manifold triangles

clear all, close all, clc;

addpath('../src');
addpath('../data');

% load('filled_cube.mat'); % 6 triangles removed
load('half_filled_octahedron.mat'); % half octahedron remains

plot_mesh(V,T);
alpha(0.5);

T_out = remove_non_manifold_triangles(T);
plot_mesh(V,T_out);