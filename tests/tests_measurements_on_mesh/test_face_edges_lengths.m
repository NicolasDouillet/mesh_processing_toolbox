% test face_edges_lengths

clc;

addpath(genpath('../../src'));
addpath('../../data');


% filename = 'tetrahedron';  % 2*sqrt(2)/sqrt(3) for all edges
% filename = 'cube';         % either 2/sqrt(3) or 2*sqrt(2)/sqrt(3)
filename = 'octahedron';   % sqrt(2) for all edges 
% filename = 'icosahedron';  % 2/sqrt((5+sqrt(5))/2) for all edges


load(strcat(filename,'.mat'));
face_ids = 1:size(T,1);
fel = face_edges_lengths(V,T,face_ids)