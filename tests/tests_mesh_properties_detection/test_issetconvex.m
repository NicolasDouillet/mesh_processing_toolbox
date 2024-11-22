% test issetconvex

clc;

addpath(genpath('../../src'));
addpath('../../data');


% Closed surfaces only
filenames = {'tetrahedron';...                        % true  (1) expected 
             'cube';...                               % true  (1) expected 
             'octahedron';...                         % true  (1) expected 
             'icosahedron';...                        % true  (1) expected                
             'dodecahedron';...                       % true  (1) expected -> failure because of coplanar points
             'dodecahedron2';...                      % true  (1) expected
             'geoid_lvl_16';...                       % true  (1) expected
             'ovoid';...                              % true  (1) expected
             'Reuleaux_tetrahedron';                  % true  (1) expected
             'sinusoidal_dodecahedron_LR';...         % false (0) expected
             'sinusoidal_dodecahedron_MR';...         % false (0) expected
             'sinusoidal_icosahedron_ULR';...         % false (0) expected
             'sinusoidal_icosahedron_MR';...          % false (0) expected
             'inverted_sinusoidal_icosahedron_MR';... % false (0) expected
             'torus_light';...                        % false (0) expected
             'kitten';...                             % false (0) expected 
             'Gargoyle_5k';...                        % false (0) expected
             'Armadillo_10k'};                        % false (0) expected

filename = strcat(cell2mat(filenames(9,1)),'.mat');         
load(filename);

% plot_mesh(V,T);
issetconvex(V)