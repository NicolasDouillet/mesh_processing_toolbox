% test min_max_edge_length

clc;

addpath(genpath('../src'));
addpath('../data');

filenames = {'tetrahedron';... % min = 2*sqrt(2)/sqrt(3); max = 2*sqrt(2)/sqrt(3)     -> ok
             'cube';...        % min = 2/sqrt(3);         max = 2*sqrt(2)/sqrt(3)     -> ok
             'octahedron';...  % min = sqrt(2);           max = sqrt(2)               -> ok
             'icosahedron';... % min = 2/sqrt(2 + phi);   max = 2/sqrt(2 + phi)       -> ok
             'dodecahedron'    %                          max = 4/sqrt(3)/(1+sqrt(5)) -> ok
             };

id = 5; % €|[ 1; 5 ]|
filename = strcat(cell2mat(filenames(id,1)),'.mat');         
load(filename);

disp('Minimum edge length of the mesh is : ');
miel = min_edge_length(V,T)

disp('Maximum edge length of the mesh is : ');
mael = max_edge_length(V,T)