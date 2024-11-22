% test show_mesh_holes_and_boundary

clc;

addpath(genpath('../../src'));
addpath('../../data');


% load('meshed_mtlb_logo.mat');
load('kitten_components.mat');
% load('X_trunk_cut.mat');


show_mesh_boundary_and_holes(V,T);
axis equal; % square;