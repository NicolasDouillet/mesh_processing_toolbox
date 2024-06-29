% test face_normals

clc;

addpath(genpath('../src'));
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
             'Armadillo_10k';...             
             };

filename = strcat(cell2mat(filenames(13,1)),'.mat');         
load(filename);

% % If needed
% T = reorient_all_faces_coherently(V,T);
% T = flip_faces_orientation(T);

select_face_normals(V,T);