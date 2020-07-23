% test quick_hull

clear all, close all, clc;

addpath('../src');
addpath('../data');


nb_vtx = 256;
X = 2*(rand(nb_vtx,1)-0.5);
Y = 2*(rand(nb_vtx,1)-0.5);
Z = 2*(rand(nb_vtx,1)-0.5);

Rho = X.^2 + Y.^2 + Z.^2;
i = Rho <= 1;
X = X(i);
Y = Y(i);
Z = Z(i);
V = cat(2,X,Y,Z);

Ch = convhull(V(:,1),V(:,2),V(:,3));
Qh = quick_hull(V);

isequal(sortrows(sort(Qh,2)),sortrows(sort(Ch,2)))

plot_mesh(V,Ch);
alpha(0.5);
axis equal, axis square;
view(3);

plot_mesh(V,Qh), hold on;
alpha(0.5);
axis equal, axis square;
view(3);