% test flip_edge

clc;

addpath(genpath('../../src'));
addpath('../../data');


I = [1 0 0];
J = [0 1 0];
K = [0 0 1];
O = [0 0 0];

V = cat(1,I,J,K,O);

T = [4 1 2;...
     4 2 3];
 
select_face_normals(V,T); 

edg2split = [2 4];
T = flip_edge(T,edg2split);
select_face_normals(V,T); 