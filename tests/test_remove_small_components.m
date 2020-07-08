% test remove_small_components

clear all, close all, clc;

addpath('../src');
addpath('../data');

filename = 'kitten_components'; % 4 components
% filename = 'Gargoyle_5k'; % 3 components
% filename = 'singularity'; % 3 components

load(strcat(filename,'.mat'));
[cc_nb,components] = segment_connected_components(T);

% percentage of the total number of triangles under which a component is
% removed
pct2rm = 5; % 5 : kitten right ear removed % 7 kitten both ears removed 

[T_out,V_out] = remove_small_components(components,pct2rm,V,true);
plot_mesh(V_out,T_out);