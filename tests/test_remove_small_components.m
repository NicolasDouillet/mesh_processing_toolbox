% test remove_small_components

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

[cc_nb,components] = segment_connected_components(T);

% percentage of the total number of triangles
% under which a component is removed

pct2rm = 2; % 5 : kitten right ear removed % 7 kitten both ears removed 

[T_out,V_out] = remove_small_components(components,pct2rm,V,true);
plot_mesh(V_out,T_out);