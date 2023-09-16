% test erode_mesh_boundaries_and_holes

clear all, close all, clc;

addpath('../src');
addpath('../data');


load('kitten_holed.mat');
% load('kitten_components.mat');

depth = 1;
[V,T] = erode_mesh_boundaries_and_holes(V,T,depth,'smooth'); % 'saw'
show_mesh_boundaries_and_holes(V,T);
view(180,0);