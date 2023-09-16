% test remove non manifold vertices

clear all, close all, clc;

addpath('../src');
addpath('../data');


% load('singularity.mat'); % no vertex, no triangle remaining
load('kitten_holed.mat');

[V,T] = remove_non_manifold_vertices(V,T);
plot_mesh(V,T);