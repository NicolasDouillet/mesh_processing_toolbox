% test erode_mesh_holes_and_boundary

clear all, close all, clc;

addpath('../src');
addpath('../data');

load('kitten_holed.mat');
% load('kitten_components.mat');

depth = 1;
[V,T] = erode_mesh_holes_and_boundary(V,T,depth,'smooth'); % 'saw'
show_holes_and_boundary(V,T);