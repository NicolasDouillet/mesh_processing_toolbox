% test remove_self_intersecting_triangles

clc;

addpath(genpath('../src'));
addpath('../data');


% load('cross_filled_cube.mat'); % 4 intern traingles + 4 bottom and top triangles removed
load('cross_filled_octahedron.mat'); % 4 intern triangles remove.

plot_mesh(V,T);
alpha(0.5);

T_out = remove_self_intersecting_triangles(V,T);

plot_mesh(V,T_out);
alpha(0.5);



