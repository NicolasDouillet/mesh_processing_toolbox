% test quad2trimesh

clc;

addpath(genpath('../../src'));
addpath('../../data');


load('cube_quad_meshed.mat');

select_face_normals(V,Q);
T = quad2trimesh(Q);
select_face_normals(V,T);