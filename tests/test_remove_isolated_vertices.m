% test remove_isolated_vertices

clear all, close all, clc;

addpath('../src');
addpath('../data');


load('geoid_lvl_16.mat');
N = randi(9) % maximum number of isolated vertices
V = cat(1,V,rand(N,3));

tic;
[V_out,T] = remove_isolated_vertices(V,T);
fprintf('%d isolated vertices removed in %d seconds.\n',size(V,1)-size(V_out,1),toc);
