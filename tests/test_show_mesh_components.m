% test show_mesh_components

clear all, close all, clc;

addpath('../src');
addpath('../data');


filename = 'kitten_components'; % 4 components
% filename = 'singularity'; % 3 components

load(strcat(filename,'.mat'));
[cc_nb, components] = segment_connected_components(T);
show_mesh_components(V,components);
view(3);