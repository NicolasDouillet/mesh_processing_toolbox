% test clone_solve_non_manifold_vertices

clc;

addpath(genpath('../../src'));
addpath('../../data');


% load('singularity'); % 1 nmnfld vertex to remove
load('kitten_holed.mat'); % 5 non ma,nifold vertices to remove | flat triangle(s) created -> pb not solved yet

nmnfld_vtx_id = select_non_manifold_vertices(V,T,true);
[V,T] = clone_solve_non_manifold_vertices(V,T,nmnfld_vtx_id); 
nmnfld_vtx_id = select_non_manifold_vertices(V,T,true);