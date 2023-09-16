% test compute_mesh_total_area

clear all, close all, clc;

addpath('../src');
addpath('../data');


filenames = {'tetrahedron';...  % S = 8/sqrt(3) -> ok
             'cube';...         % S = 8 -> ok
             'octahedron';...   % S = 4*sqrt(3) -> ok
             'icosahedron';... 
             'dodecahedron';...
             'geoid_lvl_16';... % S =12.5664 ~ 4*pi -> ok
             'meshed_mtlb_logo';...
             'kitten';...       % S = 16898 ~ 1.689798 -> ok
             'Gargoyle_3k';...
             'Gargoyle_5k';...  % S = 45855 = 45855 -> ok
             'Armadillo_10k'};

filename = strcat(cell2mat(filenames(1,1)),'.mat');         
load(filename);

% % If NaN encountered (Gargoyle_5k for instance)
% [V,T] = remove_flat_triangles(V,T);

mesh_area = compute_mesh_total_area(V, T)