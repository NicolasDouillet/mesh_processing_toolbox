% test select_edge_normals

clc;

addpath(genpath('../src/'));
addpath('../data');


filenames = {'tetrahedron';...
             'cube';...
             'octahedron';...
             'icosahedron';...
             'dodecahedron';...
             'dodecahedron2'                       
             };

filename = strcat(cell2mat(filenames(2,1)),'.mat');         
load(filename);


N = face_normals(V,T);
E = query_edg_list(T);
select_edge_normals(V,T,N,E);