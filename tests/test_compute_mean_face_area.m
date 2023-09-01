% test compute_mean_face_area

clear all, close all, clc;

addpath('../src');
addpath('../data');

             
% 'tetrahedron'
filename = strcat('tetrahedron','.mat'); % attempted : m_tetra = 2/sqrt(3)    
load(filename);

m_tetra = compute_mean_face_area(V, T)


% 'cube'
filename = strcat('cube','.mat'); % attempted : : attempted : m_cube = 2/3 
load(filename);

m_cube = compute_mean_face_area(V, T)


% 'octahedron'        
filename = strcat('octahedron','.mat'); % attempted : m_octa = 0.5*sqrt(3)    
load(filename);

m_octa = compute_mean_face_area(V, T)