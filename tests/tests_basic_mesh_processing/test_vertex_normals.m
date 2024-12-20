% test vertex_normals

clc;

addpath(genpath('../../src'));
addpath('../../data');


filenames = {'tetrahedron';...
             'cube';...
             'octahedron';...
             'icosahedron';...
             'dodecahedron';...
             'geoid_lvl_16';...
             'meshed_mtlb_logo';...
             'kitten';...
             'Gargoyle_3k';...
             'Gargoyle_5k';...
             'Armadillo_10k'};

filename = strcat(cell2mat(filenames(5,1)),'.mat');         
load(filename);

% % If needed
% T = reorient_all_faces_coherently(V,T);
% T = flip_faces_orientation(T);

ngb_degre = 1;
select_vertex_normals(V,T,ngb_degre);