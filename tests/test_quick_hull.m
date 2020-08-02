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

Vc = V;
Ch = convhull(Vc(:,1),Vc(:,2),Vc(:,3));
[Vc,Ch] = remove_vertices(setdiff(1:size(Vc,1),unique(Ch(:))),Vc,Ch,'indices');
plot_mesh(Vc,Ch);
alpha(0.5);
axis equal, axis square;
view(3);

[V,Qh] = quick_hull(V);
plot_mesh(V,Qh), hold on;
alpha(0.5);
axis equal, axis square;
view(3);

isequal(sortrows(sort(Qh,2)),sortrows(sort(Ch,2)))