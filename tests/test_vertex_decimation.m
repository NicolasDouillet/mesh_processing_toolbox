% test vertex_decimation

clear all, close all, clc;

addpath('../src');
addpath('../data');

load('kitten.mat');
plot_mesh(V,T);

vtx_idx2suppr = 1:100;
[V,T] = vertex_decimation(V,T,vtx_idx2suppr);
plot_mesh(V,T);