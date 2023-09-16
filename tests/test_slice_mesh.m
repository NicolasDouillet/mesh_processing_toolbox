% Test slice_mesh

clear all, close all, clc;

addpath('../src');
addpath('../data/');


load('Gargoyle_5k.mat');
thres = 50;
n = [0 0 1];
P = [0 0 thres];
slices_nb_max_contours = 4;

% load('kitten.mat');
% thres = -0.13;
% n = [0 0 1];
% P = [0 0 thres];
% slices_nb_max_contours = 3;

% load('Armadillo_20k.mat');
% thres = -11;
% n = [0 0 1];
% P = [0 0 thres];
% slices_nb_max_contours = 6;

% load('Cthulhu_skull.mat');
% thres = 25;
% n = [0 0 1];
% P = [0 0 thres];
% slices_nb_max_contours = 12;

slc_step = 3;
raw_edges_list = query_edges_list(T,'sorted');
srt_itx_vtx_lsts = slice_mesh(V,T,n,P,true,slices_nb_max_contours,'vertical',slc_step);

plot_mesh(V,T), shading interp, camlight left;
draw_slice_contours({srt_itx_vtx_lsts});
patch([max(V(:,1)) min(V(:,1)) min(V(:,1)) max(V(:,1))], [max(V(:,2)) max(V(:,2)) min(V(:,2)) min(V(:,2))], thres*ones(1,4), [1 1 1 1], 'FaceColor', [1 1 0]), hold on;
alpha(0.5);
view(142.5,30);