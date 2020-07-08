% test compute_mesh_total_area

clear all, close all, clc;

addpath('../src');
addpath('../data');

filenames = {'tetrahedron';...
             'cube';...         % ~8 ok
             'octahedron';...
             'icosahedron';...
             'dodecahedron';...
             'geoid_lvl_16';... % 12.5664 ~ 4*pi -> ok
             'meshed_mtlb_logo';...
             'kitten';... % 16898 ~ 1.689798 -> ok
             'Gargoyle_3k';...
             'Gargoyle_5k';... % 45855 = 45855 -> ok
             'Armadillo_10k'};

filename = strcat(cell2mat(filenames(6,1)),'.mat');         
load(filename);

% % If NaN encountered (Gargoyle_5k for instance)
% [V,T] = remove_flat_triangles(V,T);

mesh_area = compute_mesh_total_area(V, T)