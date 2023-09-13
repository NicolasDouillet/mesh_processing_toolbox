% test smooth_mesh

clear all, close all, clc;

addpath('../src');
addpath('../data');

load('data/Gargoyle_5k.mat');
% load('data/Armadillo_10k.mat');

plot_mesh(V,T), shading interp, camlight right;

N = compute_vertex_normals(V,T,2);
nb_iterations = 1;
ngb_degre = 1;
V = smooth_mesh(V,T,nb_iterations,ngb_degre);

plot_mesh(V,T), shading interp, camlight right;