% Test find_neighbor_triangle_indices


clear all, close all, clc;

addpath('../src');
addpath('../data');

% 'tetrahedron'
% 'cube'
% 'octahedron'
             
filename = strcat('octahedron','.mat');         
load(filename);

ngb_T = cell2mat(find_neighbor_triangle_indices(T,1)) % (2 4 5)' expected
