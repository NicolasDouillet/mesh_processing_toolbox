% test triangle_collapse

clear all, close all, clc;

addpath('../src');
addpath('../data');

load('kitten.mat');
plot_mesh(V,T);

tgl_idx2collapse = [1,28,59]; % indices

[V,T] = triangle_collapse(V,T,tgl_idx2collapse);
plot_mesh(V,T);

% Minus 2 x nb_tgl vertices suppressed in the vertex set (if not linked)
% Minus 4 x nb_tgl triangles suppressed in the triangulation (if not linked)