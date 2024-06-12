% test split edge

clear all, close all, clc;

addpath('../src');
addpath('../data');


% load('disk.mat');
% plot_mesh(V,T);
% 
% boundaries = select_mesh_boundaries_and_holes(V,T);
% boundary_edges = cell2mat(boundaries(1));
% boundary_edges = reshape(circshift(repelem(boundary_edges,2),1)',[2,numel(boundary_edges)])';
% 
% [V,T] = split_edge(V,T,boundary_edges);
% select_face_normals(V,T);


load('octahedron.mat');
[V,T] = split_edge(V,T,[1 2]); % still one edge at a time for the moment
[V,T] = split_edge(V,T,[1 5]);
[V,T] = split_edge(V,T,[3 4]);
select_face_normals(V,T);