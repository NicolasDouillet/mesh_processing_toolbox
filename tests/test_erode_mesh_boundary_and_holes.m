% test erode_mesh_boundary_and_holes

clc;

addpath(genpath('../src'));
addpath('../data');


load('kitten_holed.mat');
% load('kitten_components.mat');

show_mesh_boundary_and_holes(V,T);
view(180,0);

depth = 1;
[V,T] = erode_mesh_boundary_and_holes(V,T,depth,'smooth'); % 'saw'
show_mesh_boundary_and_holes(V,T);
view(180,0);