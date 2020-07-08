% test ismesh2Dmanifold

clear all, close all, clc;

addpath('../src');
addpath('../data');

% load('cube.mat'); % 1 / true
% load('filled_cube.mat'); % 0 / false
% load('cross_filled_cube.mat'); % 0 / false
load('octahedron.mat'); % 1 / true
% load('half_filled_octahedron.mat'); % 0 / false
% load('filled_octahedron.mat'); % 0 / false
% load('cross_filled_octahedron.mat'); % 0 / false
% load('singularity.mat'); % 0 / false

b = ismesh2Dmanifold(V,T)