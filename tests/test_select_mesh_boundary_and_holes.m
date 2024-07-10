% test select_mesh_boundary_and_holes

clc;

addpath(genpath('../src'));
addpath('../data');


% load('kitten_holed.mat');
load('kitten_components.mat');
% load('meshed_mtlb_logo.mat');

nmnfld_vtx_id = select_non_manifold_vertices(V,T,false);
[V,T] = clone_solve_non_manifold_vertices(V,T,nmnfld_vtx_id);
boundary = select_mesh_boundary_and_holes(V,T);