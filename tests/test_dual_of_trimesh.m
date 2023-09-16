% Test dual_of_trimesh

clear all, close all, clc;

addpath('../src');
addpath('../data');


filenames = {'tetrahedron';...
             'cube';...
             'octahedron';...
             'icosahedron';...
             'dodecahedron';...
             'dodecahedron2';...
             'disk';...
             'torus_light';...
             'torus';...
             'geoid_lvl_16';...
             'meshed_mtlb_logo';...
             'kitten';...
             'Gargoyle_3k';...
             'Gargoyle_5k';...
             'Armadillo_10k'};

         
filename = strcat(cell2mat(filenames(8,1)),'.mat');         
load(filename);

plot_mesh(V,T);

[V_dual,T_dual] = dual_of_trimesh(V,T);
plot_mesh(V_dual,T_dual);       