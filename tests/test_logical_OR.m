% test logical_OR

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'cube';...
             'cross_filled_cube';...       % expected union : 8 vertices, 16 triangles (6x2 + 4x2)
             
             'octahedron';...
             'cross_filled_octahedron';... % expected union : 6 vertices, 12 triangles (8 + 4)
                          
             'dodecahedron';...
             'dodecahedron2';...           % expected union : 32 vertices, 96 triangles
             
             'kitten';...
             'kitten_holed';...
             'kitten_big_hole';...
             'kitten_components';...       % + V2 argument mandatory
             };
             
         
filename1 = strcat(cell2mat(filenames(7,1)),'.mat');         
load(filename1);

V1 = V;
T1 = T;

filename2 = strcat(cell2mat(filenames(9,1)),'.mat');         
load(filename2);

V2 = V; % +2 => point set translation for better visibility
T2 = T;

clear V, clear T;

precision = 1e9*eps;
[TX,VX] = logical_OR(T1,T2,V1,V2,precision);
plot_mesh(VX,TX);
alpha(0.5);