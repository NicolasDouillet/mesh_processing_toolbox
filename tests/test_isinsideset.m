% test isinsideset

clear all, close all, clc;

addpath('../src');
addpath('../data');


% Closed watertight 2D-manifold triangulated surfaces only
filenames = {'tetrahedron';...
             'cube';...
             'octahedron';...
             'icosahedron';...
             'dodecahedron';...
             'sinusoidal_icosahedron_ULR';...
             'sinusoidal_icosahedron_MR';...
             'sinusoidal_dodecahedron_LR';...
             'sinusoidal_dodecahedron_MR';...
             'inverted_sinusoidal_icosahedron_MR';...
             'geoid_lvl_16';...
             'concave_Reuleaux_tetrahedron';...  
             'kitten';...                    
             'Armadillo_10k';... 
             'Armadillo_20k';...
             'rm_int_tgl_test'
             };

id = 16;         
         
filename = strcat(cell2mat(filenames(id,1)),'.mat');         
load(filename);


% When necessary
% [V,T] = remove_duplicated_vertices(V,T); 
% T = remove_duplicated_triangles(T);
% [V,T] = remove_non_manifold_vertices(V,T);
% T = remove_non_manifold_triangles(T);
% T = reorient_all_faces_coherently(V,T); 

nb_samples = 19;

[A,B,C] = meshgrid(linspace(min(V(:,1)),max(V(:,1)),nb_samples),...
                   linspace(min(V(:,2)),max(V(:,2)),nb_samples),...
                   linspace(min(V(:,3)),max(V(:,3)),nb_samples));
               
% P = cat(2,A(:),B(:),C(:));

% boundary belonging test
P = V;

% Boundary arounds test (boundary + small noise)
% S = max(V(:,3)-min(V(:,3)));
% P = V + 0.05*S*(rand(size(V,1),3)-0.5);



h = figure;
set(h,'Position',get(0,'ScreenSize'));
trisurf(T,V(:,1),V(:,2),V(:,3)), shading faceted, hold on;

isin = double(isinsideset(V,T,P));

ColorSpec = cell2mat(cellfun(@(c) cat(2,~c,c,0),num2cell(isin,2),'un',0));
cellfun(@(r1,r2) plot3(r1(1,1),r1(1,2),r1(1,3),'+','Color',r2,'MarkerSize',6,'LineWidth',6),num2cell(P,2),num2cell(ColorSpec,2),'un',0);
set(gca, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], 'ZColor', [1 1 1]);
set(gcf,'Color',[0 0 0]);
colormap([0 1 1]);        
xlabel('X'), ylabel('Y'), zlabel('Z');
axis equal;
ax = gca;
ax.Clipping = 'off';
axis equal, axis tight;
alpha(0.5);