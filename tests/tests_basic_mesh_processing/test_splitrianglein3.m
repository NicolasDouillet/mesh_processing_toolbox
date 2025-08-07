% test splitrianglein3

clc;

addpath(genpath('../../src'));
addpath('../../data');


I = [1 0 0];
J = [0 1 0];
K = [0 0 1];

V = cat(1,I,J,K);
T = [1 2 3];
select_face_normals(V,T);

tid = 1;
new_vid = 1 + size(V,1);
[V,T] = splitrianglein3(V,T,tid,new_vid,'new',[0 0 0]);
select_face_normals(V,T);
