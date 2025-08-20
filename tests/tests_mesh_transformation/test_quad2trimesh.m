% test quad2trimesh

clc;

addpath(genpath('../../src'));
addpath('../../data');


load('cube_quad_meshed.mat');

show_face_normals(V,Q);
T = quad2trimesh(Q);
show_face_normals(V,T);