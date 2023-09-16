% test ismesh2Dmanifold

clear all, close all, clc;

addpath('../src');
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

filename = strcat(cell2mat(filenames(1,1)),'.mat');         
load(filename);

b = ismesh2Dmanifold(V,T)