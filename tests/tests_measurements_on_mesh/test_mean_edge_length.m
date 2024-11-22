% test mean_edge_length

clc;

addpath(genpath('../../src'));
addpath('../../data');

             
filenames = {'tetrahedron';... % expected m_tetra = 2*sqrt(2/3)
             'cube';...        % expected m_cube ~1.3141 ~(12*2*0.5774+6*2*0.5774*sqrt(2))/18
             'octahedron';...  % expected m_octa = sqrt(2)                      
             };

filename = strcat(cell2mat(filenames(1,1)),'.mat');         
load(filename);           
m = mean_edge_length(V, T)


