% test mesh_convex_hull

clear all, close all, clc;

addpath('../src');
addpath('../data');


nb_vtx = 64;
X = 2*(rand(nb_vtx,1)-0.5);
Y = 2*(rand(nb_vtx,1)-0.5);
Z = 2*(rand(nb_vtx,1)-0.5);

Rho = X.^2 + Y.^2 + Z.^2;
i = Rho <= 1;
X = X(i);
Y = Y(i);
Z = Z(i);
V = cat(2,X,Y,Z);

Ch = mesh_convex_hull(V);
Cv = convhull(V(:,1),V(:,2),V(:,3));

isequal(sortrows(sort(Ch,2)),sortrows(sort(Cv,2)))

plot_mesh(V,Cv);
alpha(0.5);
axis equal, axis square;

plot_mesh(V,Ch);
alpha(0.5);
axis equal, axis square;