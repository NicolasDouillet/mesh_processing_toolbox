% test point_to_mesh_min_distance

clc;

addpath(genpath('../../src'));
addpath('../../data');


filenames = {'tetrahedron';... % P = [0 0 -1], min_dst = 2/3 -> ok
             'cube';...        % P = [0 0 0], min_dst = sqrt(3)/3 -> ok
             'octahedron';...  % P = [1 1 1], min_dst = 2*sqrt(3)/3 -> ok
             'icosahedron';... % P = [0 0 0], min_dst = 0.7947 -> ok                    
             };

filename = strcat(cell2mat(filenames(1,1)),'.mat');         
load(filename);

P = [0 0 -1];

min_dst = point_to_mesh_min_distance(P, V, T)