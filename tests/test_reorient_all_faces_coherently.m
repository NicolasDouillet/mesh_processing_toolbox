% test reorient_all_faces_coherently

clear all, close all, clc;

addpath('../src');
addpath('../data');


load('randoriented_ico.mat');

select_face_normals(V,T);
T = reorient_all_faces_coherently(V,T);

T = flip_faces_orientation(T); % if necessary
select_face_normals(V,T);