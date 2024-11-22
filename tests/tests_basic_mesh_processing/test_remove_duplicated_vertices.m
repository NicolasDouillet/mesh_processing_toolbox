% test remove duplicated _vertices

clc;

addpath(genpath('../../src'));
addpath('../../data');


R = rand(6,3);
V = cat(1,R,R)

T = [7 8 9;...
     10 11 12];
 
[V,T] = remove_duplicated_vertices(V,T,eps) 