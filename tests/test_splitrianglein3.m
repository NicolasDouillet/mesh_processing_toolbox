% test splitrianglein3

clear all, close all, clc;

addpath('../src');
addpath('../data/');

I = [1 0 0];
J = [0 1 0];
K = [0 0 1];

V = cat(1,I,J,K);
T = [1 2 3];
select_face_normals(V,T);

tid = 1;
O = [0 0 0];
[V, new_vid] = add_vertices(O,V);
T = splitrianglein3(T,tid,new_vid);
select_face_normals(V,T);
