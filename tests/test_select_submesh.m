% test select_submesh

clc;

addpath(genpath('../src'));
addpath('../data');


% #1 
load('data/Gargoyle_3k.mat');

plot_mesh(V,T);
view(-90,0);

n = [0 1 1];
I = [-23 -751 -13];
[V_out,T_out] = select_submesh(V,T,n,I); % top part Gargoyle
plot_mesh(V_out,T_out);
view(-90,0);

% % #2
% load('data/Armadillo_10k.mat');
% n = [-1 0 0];
% I = [0 0 0];
% [V_out,T_out] = select_submesh(V,T,n,I); % half left Armadillo 
% plot_mesh(V_out,T_out);