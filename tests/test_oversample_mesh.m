% test oversample_mesh

clear all, close all, clc;

addpath('../src');
addpath('../data');


% 'tetrahedron'
% 'cube'
% 'octahedron'       
filename = strcat('octahedron','.mat'); 
load(filename);

[V,T] = oversample_mesh(V,T);

select_face_normals(V,T);