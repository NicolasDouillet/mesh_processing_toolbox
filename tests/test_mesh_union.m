% test mesh_union

clear all, close all, clc;

addpath('../src');
addpath('../data');

filenames = {'tetrahedron';...  
             'cube';...         
             'octahedron';...   
             'icosahedron';...  
             'dodecahedron';...
             'geoid_lvl_16'};        
             
filename1 = strcat(cell2mat(filenames(6,1)),'.mat');         
load(filename1);

V1 = V;
T1 = T;

filename2 = strcat(cell2mat(filenames(1,1)),'.mat');         
load(filename2);

V2 = V + 2;
T2 = T;

[V,T] = mesh_union(V1,V2,T1,T2);
plot_mesh(V,T);