% test show_mesh_holes_and_boundary

clear all, close all, clc;

addpath('../src');
addpath('../data');

% load('meshed_mtlb_logo.mat');
load('kitten_components.mat');

show_holes_and_boundary(V,T);
axis equal; % square;