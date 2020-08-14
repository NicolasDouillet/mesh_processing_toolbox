% test quick_hull

clear all, close all, clc;

addpath('../src');
addpath('../data');


nb_vtx = 128;
X = 2*(rand(nb_vtx,1)-0.5);
Y = 2*(rand(nb_vtx,1)-0.5);
Z = 2*(rand(nb_vtx,1)-0.5);

Rho = X.^2 + Y.^2 + Z.^2;
i = Rho <= 1;
X = X(i);
Y = Y(i);
Z = Z(i);
V = cat(2,X,Y,Z);

% load('torus_light.mat');

Vc = V;
Cv = convhull(Vc(:,1),Vc(:,2),Vc(:,3));

% For random point sets only
[Vc,Cv] = remove_vertices(setdiff(1:size(Vc,1),unique(Cv(:))),Vc,Cv,'indices');

plot_mesh(Vc,Cv);
axis equal;
view(3);

[V,Qh] = quick_hull(V);

if isequal(sortrows(sort(Cv,2)),sortrows(sort(Qh,2)))
    
    disp('Same point sets and triangulations.');
    
else
    
    disp('Point sets and triangulations are different, probably due to some coplanar points.');
    
end

plot_mesh(V,Qh), hold on;
axis equal;
view(3);