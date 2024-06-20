% test switch_neighbor_pair_triangles

clear all, close all, clc;

addpath('../src');
addpath('../data/');

I = [1 0 0];
J = [0 1 0];
K = [0 0 1];
O = [0 0 0];

V = cat(1,I,J,K,O);

T = [4 1 2;...
     4 2 3];
 
select_face_normals(V,T); 

tid1 = 1;
tid2 = 2;
T = switch_neighbor_pair_triangles(T,tid1,tid2);
select_face_normals(V,T); 