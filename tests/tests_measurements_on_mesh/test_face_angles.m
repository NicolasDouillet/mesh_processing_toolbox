% test face_angles

clc;

addpath(genpath('../../src'));
addpath('../../data');


% filename = 'tetrahedron';  % pi/3 rad = 60° for all angles
filename = 'cube';         % either pi/2 rad / 90° or pi/4 rad / 45° angles only
% filename = 'octahedron';   % pi/3 rad = 60° for all angles 
% filename = 'icosahedron';  % pi/3 rad = 60° for all angles


load(strcat(filename,'.mat'));
face_ids = 1:size(T,1);

fa = face_angles(V,T,face_ids);
fa_deg = 180*fa/pi