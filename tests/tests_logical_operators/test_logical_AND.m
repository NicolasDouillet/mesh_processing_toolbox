% test logical_AND

clc;

addpath(genpath('../../src'));
addpath('../../data');


% Example #1
filenames = {'kitten';...
             'kitten_holed';...
             'kitten_big_hole';...
             'kitten_components';...            % + V2 argument mandatory
             
             'dodecahedron_trimesh_regular';...
             'dodecahedron_trimesh_optim';...   % no common face,  20 common vertices                          
             
             'octahedron';...
             'cross_filled_octahedron';...      %  8 common faces,  6 common vertices
             
             'cube';...
             'cross_filled_cube'                % 12 common faces,  8 common vertices
             };
        
         
filename1 = strcat(cell2mat(filenames(1,1)),'.mat');         
load(filename1);

V1 = V;
T1 = T;

filename2 = strcat(cell2mat(filenames(4,1)),'.mat');         
load(filename2);

V2 = V;
T2 = T;

clear V, clear T;

precision = 1e9*eps;
[TX,VX] = logical_AND(T1,T2,V1,V2,precision);
plot_mesh(VX,TX);



% % Example #2
% % Trivial random example with one unique point set
% V1 = rand(19,3);
% 
% T1 = [1 2 3;...
%       4 5 6;...
%       7 8 9;...
%       10 11 12;
%       13 14 15];
% 
% T2 = cat(1,T1(1:2:end,:),[1 4 7; 2 5 8; 3 6 9]);
% 
% [T,V] = logical_AND(T1,T2,V1); % expected intersetion mesh is [1 2 3; 7 8 9; 13 14 15]
% % plot_mesh(V,T);


% Example #3
% Two distinct point sets and meshes
% V1 = rand(19,3);
% 
% T1 = [1 2 3;...
%       4 5 6;...
%       7 8 9;...
%       10 11 12;...
%       13 14 15;...
%       17 18 19];
% 
% % Test sans faire coincider les point sets et leurs tailles  
% V2 = cat(1,rand(3,3),V1(4:12,:),rand(5,3));
% T2 = cat(1,T1(1:2:end,:),[1 4 7; 2 5 8]);
% 
% [T,V] = logical_AND(T1,T2,V1,V2); % expected intersection mesh is [4 5 6]


% Double plot des deux triangulations superposées avec les indices
% originaux, pour vérifier à la fin
