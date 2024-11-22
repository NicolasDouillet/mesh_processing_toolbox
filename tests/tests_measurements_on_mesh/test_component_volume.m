% test component_volume

clc;

addpath(genpath('../../src'));
addpath('../../data');


load('union_mesh.mat');

[~,C] = segment_connected_components(T,'explicit');
component_volume = component_volume(V,C) % 4.1797    1.5396 -> ok