% test mesh_convex_hull

clear all, close all, clc;

addpath('../src');
addpath('../data');


N = 256;
X = 2*(rand(N,1)-0.5);
Y = 2*(rand(N,1)-0.5);
Z = 2*(rand(N,1)-0.5);

Rho = X.^2 + Y.^2 + Z.^2;
i = Rho <= 1;
X = X(i);
Y = Y(i);
Z = Z(i);

V = cat(2,X,Y,Z);

T = mesh_convex_hull(V);
% Tc = convhull(V(:,1),V(:,2),V(:,3));

% ismeshwatertight(V,T,'closed')
% isequal(sortrows(T),sortrows(sort(Tc,2)))

% plot_mesh(V,Tc);
% alpha(0.5);
% axis equal, axis square;

plot_mesh(V,T);
alpha(0.5);
axis equal, axis square;