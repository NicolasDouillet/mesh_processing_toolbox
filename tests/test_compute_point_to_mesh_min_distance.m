% test compute_point_to_mesh_min_distance

clear all, close all, clc;

addpath('../src');
addpath('../data');

% load('tetrahedron.mat'); % P = [0 0 -1], min_dst = 2/3 -> ok
% load('cube.mat');        % P = [0 0 0], min_dst = sqrt(3)/3 -> ok
% load('octahedron.mat');  % P = [1 1 1], min_dst = 2*sqrt(3)/3 -> ok
load('icosahedron.mat');   % P = [0 0 0], min_dst = 0.7947 -> ok

P = [0 0 0];

min_dst = compute_point_to_mesh_min_distance(P, V, T)