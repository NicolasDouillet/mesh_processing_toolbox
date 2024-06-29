% test split edge

clc;

addpath(genpath('../src'));
addpath('../data');


load('disk.mat');

boundary = select_mesh_boundary_and_holes(V,T);
boundary_edges = cell2mat(boundary(1));
boundary_edges = reshape(circshift(repelem(boundary_edges,2),1)',[2,numel(boundary_edges)])';


for i = 1:size(boundary_edges,1)
    
    [V,T] = split_edge(V,T,boundary_edges(i,:));
    
end

plot_mesh(V,T);


% load('octahedron.mat');
% [V,T] = split_edge(V,T,[1 2]); % still one edge at a time for the moment
% [V,T] = split_edge(V,T,[1 5]);
% [V,T] = split_edge(V,T,[3 4]);
% select_face_normals(V,T);