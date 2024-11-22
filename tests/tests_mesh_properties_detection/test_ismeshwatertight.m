% test ismeshwatertight

clc;

addpath(genpath('../../src'));
addpath('../../data');


load('kitten_holed.mat');
% load('meshed_mtlb_logo.mat');

% If necessary (case of kitten_holed.mat for instance)
nmnfld_vtx_id = select_non_manifold_vertices(V,T,false);
[V,T] = clone_solve_nmnfld_vertices(V,T,nmnfld_vtx_id);

b = ismeshwatertight(V,T,'closed')