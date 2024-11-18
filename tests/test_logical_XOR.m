% test logical_XOR

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'cube';...
             'cross_filled_cube';...       % precision = 1e3*eps ok
             
             'octahedron';...
             'cross_filled_octahedron';... % precision = 1e3*eps ok
             
             'kitten';...
             'kitten_holed';...
             'kitten_big_hole';...
             'kitten_components';...       % + V2 argument mandatory
             };
             
         
filename1 = strcat(cell2mat(filenames(5,1)),'.mat');         
load(filename1);

V1 = V;
T1 = T;

filename2 = strcat(cell2mat(filenames(8,1)),'.mat');         
load(filename2);

V2 = V;
T2 = T;

clear V, clear T;

precision = 1e9*eps;
[TX,VX] = logical_XOR(T1,T2,V1,V2,precision);
plot_mesh(V1,TX);
% alpha(0.5);