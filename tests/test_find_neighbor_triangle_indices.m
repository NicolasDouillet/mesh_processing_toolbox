% Test find_neighbor_triangle_indices

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'tetrahedron';... % (2 3 4)' expected 
             'cube';...        % (2 3 4)' expected
             'octahedron';...  % (2 4 5)' expected
             'icosahedron';...                    
             };

filename = strcat(cell2mat(filenames(2,1)),'.mat');         
load(filename)

ngb_T = cell2mat(find_neighbor_triangle_indices(T,1)) 
