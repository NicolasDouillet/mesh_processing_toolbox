% test plot_bounding_box

clc;

addpath(genpath('../src'));
addpath('../data');

filenames = {'meshed_mtlb_logo';...
             'kitten';...
             'Gargoyle_3k';...
             'Gargoyle_5k';...
             'Armadillo_10k';...
             'Cthulhu_skull'
             };

id = 6;         
filename = strcat(cell2mat(filenames(id,1)),'.mat');         
load(filename);

bbox = mesh_bounding_box(V);
plot_mesh(V,T);
plot_bounding_box(bbox);