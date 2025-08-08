% test splitrianglein3

clc;

addpath(genpath('../src'));
addpath('../data');


I = [1 0 0];
J = [0 1 0];
K = [0 0 1];
M = [-1 0 0];
N = [0 -1 0];
P = [0 0 -1];
O = [0 0 0];

V = cat(1,I,J,K,M,N,P,O);
T = [1 2 3; 4 6 5];
select_face_normals(V,T);

% Test mode = 'default'
[P1,F1] = splitrianglein3(V,T,[1 2],'default');
select_face_normals(P1,F1);

% Test mode = 'insert'
tid = [1 2];
vid = [7 7];
[P2,F2] = splitrianglein3(V,T,tid,'insert',vid);
select_face_normals(P2,F2);

% Test mode = 'new'
tid = [1 2];
vid = -1;
V_new = [1 1 1; -1 -1 -1];
[P3,F3] = splitrianglein3(V,T,tid,'new',vid,V_new);
select_face_normals(P3,F3);


