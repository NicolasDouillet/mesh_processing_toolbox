% test compute_mean_edge_length

clear all, close all, clc;

addpath('../src');
addpath('../data');

             
filename = strcat('tetrahedron','.mat');
load(filename);

m_tetra = compute_mean_edge_length(V, T) % expected m_tetra = 2*sqrt(2/3)


filename = strcat('cube','.mat');
load(filename);

m_cube = compute_mean_edge_length(V, T) % expected m_cube ~1.3141 ~(12*2*0.5774+6*2*0.5774*sqrt(2))/18


filename = strcat('octahedron','.mat');
load(filename);

m_octa = compute_mean_edge_length(V, T) % expected m_octa = sqrt(2)


