% test compute_holes_and_boundary_perimeters

clear all, close all, clc;

addpath('../src');
addpath('../data');

load('kitten_holed.mat');
% load('kitten_components.mat');
% load('meshed_mtlb_logo.mat');

% If necessary (presence of non manifold vertices, 'kitten_holed.mat' for instance)
[V,T] = remove_non_manifold_vertices(V,T);

boundaries = detect_mesh_holes_and_boundary(T);
bound_lengths = compute_holes_and_boundary_perimeters(V,boundaries)