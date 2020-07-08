% test compute_component_volume

clear all, close all, clc;

addpath('../src');
addpath('../data/');

load('union_mesh.mat');

[~,C] = segment_connected_components(T,'explicit');
component_volume = compute_component_volume(V,C) % 4.1797    1.5396 -> ok