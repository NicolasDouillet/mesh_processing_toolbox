% test remove_degenerated_triangles

clc;

addpath(genpath('../src'));
addpath('../data');


load('octahedron.mat');

V = cat(1,V,[0.5 0 0.5]);
T = cat(1,T,[1 7 5]); % flat line triangle added

T_out = remove_degenerated_triangles(V,T);