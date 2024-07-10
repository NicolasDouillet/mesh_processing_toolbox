% test find_every_vertices_neighbor_indices

clc;

addpath(genpath('../src'));
addpath('../data');


load('Gargoyle_3k.mat');

nb_vtx = size(V,1);
ngb_degre = 2;
ngb_id = 163;

neighbor_list = find_every_vertices_neighbor_indices(T,ngb_degre,nb_vtx);
neighbors = cell2mat(neighbor_list(ngb_id,1));

plot_mesh(V,T);

% Vertex
plot3(V(ngb_id,1),V(ngb_id,2),V(ngb_id,3),'ro','MarkerSize',6,'Linewidth',6), hold on;

% Neighborhood
plot3(V(neighbors,1),V(neighbors,2),V(neighbors,3),'o','Color',[0 0 1],'MarkerSize',6,'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1]);
view(0,38);