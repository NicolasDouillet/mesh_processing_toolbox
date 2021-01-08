% test edge_collapse

clear all, close all, clc;

addpath('../src');
addpath('../data');

load('icosahedron.mat');
% load('dodecahedron.mat');
plot_mesh(V,T);

edg_list = [1 2; 3 4];
[V,T] = edge_collapse(V,T,edg_list);
plot_mesh(V,T);