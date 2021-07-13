% Test smooth_mesh_boundaries

clear all;

addpath('../src');
addpath('../data');


% load('kitten_big_hole.mat');
load('kitten_components.mat');

show_holes_and_boundary(V,T);
shading interp;
camlight right;
alpha(0.5);
view(3);
axis off;

boundaries = detect_mesh_holes_and_boundary(T);

nb_iterations = 2;
ngb_degre = 6;
V_out = smooth_mesh_boundaries(V,boundaries,nb_iterations,ngb_degre);

show_holes_and_boundary(V_out,T);
shading interp;
camlight right;
alpha(0.5);
view(3);
axis off;