% test smooth_mesh

clc;

addpath(genpath('../../src'));
addpath('../../data');


filenames = {'Gargoyle_3k';...
             'Gargoyle_5k';...
             'Armadillo_10k';...             
             };

filename = strcat(cell2mat(filenames(2,1)),'.mat');         
load(filename);

plot_mesh(V,T), shading interp, camlight right;

N = vertex_normals(V,T,2);
nb_iterations = 1;
ngb_degre = 1;
V = smooth_mesh(V,T,nb_iterations,ngb_degre);

plot_mesh(V,T), shading interp, camlight right;