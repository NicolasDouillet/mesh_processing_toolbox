% test select_holes_and_boundary

clear all, close all, clc;

addpath('../src');
addpath('../data');

% load('kitten_holed.mat');
load('kitten_components.mat');
% load('meshed_mtlb_logo.mat');

nmnfld_vtx_idx = select_non_manifold_vertices(V,T,false);
[V,T] = clone_solve_nmnfld_vertices(V,T,nmnfld_vtx_idx);
boundaries = select_holes_and_boundary(V,T);