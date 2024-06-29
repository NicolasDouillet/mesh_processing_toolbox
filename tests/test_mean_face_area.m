% test mean_face_area

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'tetrahedron';... % attempted : m_tetra = 2/sqrt(3)    
             'cube';...        % attempted : m_cube = 2/3 
             'octahedron';...  % attempted : m_octa = 0.5*sqrt(3)                        
             };

filename = strcat(cell2mat(filenames(3,1)),'.mat');         
load(filename);           
mean_area = mean_face_area(V, T)