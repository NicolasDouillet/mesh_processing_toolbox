% test mesh_total_area

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'tetrahedron';...  % S = 8/sqrt(3)                              -> ok
             'cube';...         % S = 8                                      -> ok
             'octahedron';...   % S = 4*sqrt(3)                              -> ok
             'icosahedron';...  % S = 20*sqrt(3)/(2+phi)                     -> ok
             'dodecahedron';... % S = (16/(1+sqrt(5))^2)*sqrt(25+10*sqrt(5)) -> ok
             'geoid_lvl_16';... % S = 12.5664 ~ 4*pi                         -> ok
             'meshed_mtlb_logo';...
             'kitten';...       % S = 16898 ~ 1.689798                       -> ok
             'Gargoyle_3k';...
             'Gargoyle_5k';...  % S = 45855 = 45855                          -> ok
             'Armadillo_10k'};


id = 5;         
filename = strcat(cell2mat(filenames(id,1)),'.mat');         
load(filename);

% % If NaN encountered (Gargoyle_5k for instance)
% [V,T] = remove_flat_triangles(V,T);

mesh_area = mesh_total_area(V, T)