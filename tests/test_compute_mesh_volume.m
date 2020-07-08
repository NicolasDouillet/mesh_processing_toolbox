% test compute_mesh_volume

clear all, close all, clc;

addpath('../src');
addpath('../data/');

% Closed surfaces only
filenames = {'tetrahedron';...  % 0.5132 -> ok
             'cube';...         % 1.5396 ~ 1.54 -> ok
             'octahedron';...   % 1.3333 ~ 4/3 -> ok
             'icosahedron';...  % 2.5362 = 2.5362 -> ok
             'dodecahedron';...
             'geoid_lvl_16';... %  4.1797 ~ 4.1888 = 4*pi/3 -> ok             
             'kitten';...       % 0.124460 ~ 0.1245 -> ok
             'Gargoyle_3k';...
             'Gargoyle_5k';...  % volume = 268186 ~ 26819 -> ok
             'Armadillo_10k'};  % 237106 = 237106  -> ok

filename = strcat(cell2mat(filenames(4,1)),'.mat');         
load(filename);

volume = compute_mesh_volume(V, T)