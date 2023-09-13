% test compute_boundaries_and_holes_perimeters

clear all, close all, clc;

addpath('../src');
addpath('../data');

load('kitten_holed.mat');
% load('kitten_components.mat');
% load('meshed_mtlb_logo.mat');

% If necessary (presence of non manifold vertices, 'kitten_holed.mat' for instance)
[V,T] = remove_non_manifold_vertices(V,T);

boundaries = detect_mesh_boundaries_and_holes(T);
bound_lengths = compute_boundaries_and_holes_perimeters(V,boundaries)