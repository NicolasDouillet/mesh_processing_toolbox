% test segment_connected_components

clc;

addpath(genpath('../../src'));
addpath('../../data');


filename = 'kitten_components'; % 4 components
% filename = 'Gargoyle_5k'; % 3 components :  3 = main + 2 isolated tetrahedrons
% filename = 'singularity'; % 3 components

load(strcat(filename,'.mat'));
[cc_nb, components] = segment_connected_components(T)