% test ismesh2Dmanifold

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'cube';...                     % 1 / true
             'filled_cube';...              % 0 / false
             'cross_filled_cube';...        % 0 / false    
             'octahedron';...               % 1 / true
             'half_filled_octahedron';...   % 0 / false
             'filled_octahedron';...        % 0 / false
             'cross_filled_octahedron';...  % 0 / false
             'singularity';...              % 0 / false            
             };

id = 1;
filename = strcat(cell2mat(filenames(id,1)),'.mat');         
load(filename);

b = ismesh2Dmanifold(V,T)