% test component_area

clear all, close all, clc;

addpath('../src');
addpath('../data');


% filename = 'kitten_components'; % 4 components : [0.8112 0.6086 0.0895 0.0604]
% filename = 'Gargoyle_5k'; % 3 components : [45855 0.0597 0.0165] 
filename = 'singularity'; % 3 components : [1 1 0.5*sqrt(2)]

load(strcat(filename,'.mat'));

% % If NaN encountered (Gargoyle_5k for instance)
% [V,T] = remove_flat_triangles(V,T);

[cc_nb, components] = segment_connected_components(T);
component_area = component_area(V,components)