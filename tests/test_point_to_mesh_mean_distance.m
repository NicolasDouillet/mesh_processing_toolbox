% test point_to_mesh_mean_distance

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'tetrahedron';... % expected m_tetra = 1/3
             'cube';...        % expected m_cube = 1/sqrt(3)
             'octahedron';...  % expected m_octa = 1/sqrt(3)
             'icosahedron';    % expected m_icosa = sqrt(1 - 4/(3*(2+0.5*(1+sqrt(5)))))
             };

filename = strcat(cell2mat(filenames(4,1)),'.mat');         
load(filename);
M = [0 0 0];
mean_dst = point_to_mesh_mean_distance(M,V,T)