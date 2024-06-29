% test show_mesh_components

clc;

addpath(genpath('../src'));
addpath('../data');


filenames = {'kitten_components';... % 4 components
             'Gargoyle_5k';...       % 3 components
             'Gargoyle_3k';...       % 5 components
             'singularity';...       % 3 components      
             };

fid = 1;          
filename = strcat(cell2mat(filenames(fid,1)),'.mat');         
load(filename);

[cc_nb, components] = segment_connected_components(T);
show_mesh_components(V,components);
view(3);