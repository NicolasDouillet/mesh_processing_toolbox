% test show_mesh_holes_and_boundary

clc;

addpath(genpath('../../src'));
addpath('../../data');


% load('meshed_mtlb_logo.mat');  % 1 boundary
% load('X_trunk_cut.mat');       % 2 boundaries
load('kitten_components.mat'); % 8 boundaries

boundaries = mesh_boundary_and_holes(T);
hole_ids = 1:6; 
show_mesh_boundary_and_holes(V,T,boundaries,hole_ids);
axis equal;