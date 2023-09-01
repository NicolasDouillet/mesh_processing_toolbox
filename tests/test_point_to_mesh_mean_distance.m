% test point_to_mesh_mean_distance

clear all, close all, clc;

addpath('../src');
addpath('../data');


% 'tetrahedron'
filename = strcat('tetrahedron','.mat'); 
load(filename);

M = [0 0 0];

m_tetra = point_to_mesh_mean_distance(M,V,T) % expected m_tetra = 1/3


filename = strcat('cube','.mat'); 
load(filename);

M = [0 0 0];

m_cube = point_to_mesh_mean_distance(M,V,T) % expected m_cube = 1/sqrt(3)


filename = strcat('octahedron','.mat'); 
load(filename);

M = [0 0 0];

m_octa = point_to_mesh_mean_distance(M,V,T) % expected m_octa = 1/sqrt(3)


filename = strcat('icosahedron','.mat'); 
load(filename);

M = [0 0 0];

m_icosa = point_to_mesh_mean_distance(M,V,T) % expected m_icosa = sqrt(1 - 4/(3*(2+0.5*(1+sqrt(5)))))