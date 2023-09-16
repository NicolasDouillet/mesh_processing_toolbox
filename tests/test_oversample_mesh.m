% test oversample_mesh

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
             'meshed_mtlb_logo';...
             'kitten';...
             'Gargoyle_3k';...                        
             };

filename = strcat(cell2mat(filenames(8,1)),'.mat');         
load(filename);

[V,T] = oversample_mesh(V,T,2);
plot_mesh(V,T);