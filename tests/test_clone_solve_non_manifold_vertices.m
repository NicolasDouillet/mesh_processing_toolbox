% test clone_solve_non_manifold_vertices

clear all, close all, clc;

addpath('../src');
addpath('../data');


% load('singularity'); % 1 nmnfld vertex to remove
load('kitten_holed.mat'); % 5 non ma,nifold vertices to remove | flat triangle(s) created -> pb not solved yet

nmnfld_vtx_idx = select_non_manifold_vertices(V,T,true);
[V,T] = clone_solve_non_manifold_vertices(V,T,nmnfld_vtx_idx); 
nmnfld_vtx_idx = select_non_manifold_vertices(V,T,true);