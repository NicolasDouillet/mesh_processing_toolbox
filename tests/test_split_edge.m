% test split edge

clear all, close all, clc;

addpath('../src');
addpath('../data');


load('disk.mat');

boundaries = select_holes_and_boundary(V,T);
boundary_edges = cell2mat(boundaries(1));
boundary_edges = reshape(circshift(repelem(boundary_edges,2),1)',[2,numel(boundary_edges)])';

[V,T] = split_edge(V,T,boundary_edges);
plot_mesh(V,T);