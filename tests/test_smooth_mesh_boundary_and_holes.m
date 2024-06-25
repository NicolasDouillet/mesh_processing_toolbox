% Test smooth_mesh_boundary_and_holes

clear all;

addpath('../src');
addpath('../data');


% load('kitten_big_hole.mat');
load('kitten_components.mat');

show_mesh_boundary_and_holes(V,T);
shading interp;
camlight left;
alpha(0.5);
view(180,0);
axis off;

boundary = detect_mesh_boundary_and_holes(T);

nb_iterations = 2;
ngb_degre = 6;
V_out = smooth_mesh_boundary_and_holes(V,boundary,nb_iterations,ngb_degre);

show_mesh_boundary_and_holes(V_out,T);
shading interp;
camlight left;
alpha(0.5);
view(180,0);
axis off;