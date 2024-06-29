% test remove_isolated_triangles

clc;

addpath(genpath('../src'));
addpath('../data');


% filename = 'kitten_isl_tgl';
load('singularity');
plot_mesh(V,T);

[V_out,T_out] = remove_isolated_triangles(V,T,true); % 1 isolated triangle removed
plot_mesh(V_out,T_out);