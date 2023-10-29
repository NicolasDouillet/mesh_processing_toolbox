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
             'sinusoidal_dodecahedron_MR';... % bug !!!
             'inverted_sinusoidal_icosahedron_MR';...
             'geoid_lvl_16';...
             'concave_Reuleaux_tetrahedron';...  
             'kitten';...                    
             'Armadillo_10k';... % bug aussi :-(
             'Armadillo_20k';... % bug encore :-/
             'rm_int_tgl_test'
             };

% Bug d'appartenance toujours vers l'intérieur, jamais vers l'extérieur
         
id = 14;         
         
filename = strcat(cell2mat(filenames(id,1)),'.mat');         
load(filename);

% When necessary
% [V,T] = remove_duplicated_vertices(V,T); 
% T = remove_duplicated_triangles(T);
% [V,T] = remove_non_manifold_vertices(V,T);
% T = remove_non_manifold_triangles(T);
% T = reorient_all_faces_coherently(V,T);
% ni = compute_vertex_normals(V,T);


% Vertex normals
G = mean(V,1);
nb_vtx = size(V,1);
vtx_idx = (1:nb_vtx)';
tgl_idx_list = cellfun(@(i) find(sum(ismember(T,i),2))',num2cell(vtx_idx,2),'un',0);

vtx_ngb_face_normals = cellfun(@(c) compute_face_normals(V,T(c,:),'norm'),tgl_idx_list,'un',0);                   
ni = cell2mat(cellfun(@(c1) mean(c1,1),vtx_ngb_face_normals,'un',0));     
ni = ni./sqrt(sum(ni.^2,2));
    
% Coherently orient outward vertex normals
orientation = sign(dot(ni,V-repmat(G,[nb_vtx,1]),1));

if ~isequal(orientation,ones(nb_vtx,1))     
    ni = ni.*orientation;    
end



nb_samples = 11;

[A,B,C] = meshgrid(linspace(min(V(:,1)),max(V(:,1)),nb_samples),...
                   linspace(min(V(:,2)),max(V(:,2)),nb_samples),...
                   linspace(min(V(:,3)),max(V(:,3)),nb_samples));

% % Regularly sampled grid test               
% P = cat(2,A(:),B(:),C(:));

% % Boundary belonging test
% P = V;

% Boundary arounds tests 
S = max(V(:,3)-min(V(:,3)));
% P = V + 0.1*S*(rand(size(V,1),3)-0.5); % boundary + small noise test
P = V - 0.005*S*ni; % boundary + normal vector direction translated vertices test



h = figure;
set(h,'Position',get(0,'ScreenSize'));
trisurf(T,V(:,1),V(:,2),V(:,3)), shading faceted, hold on;

epsilon = 1e3*eps;
isin = double(isinsideset(V,T,P,epsilon));

ColorSpec = cell2mat(cellfun(@(c) cat(2,~c,c,0),num2cell(isin,2),'un',0));
cellfun(@(r1,r2) plot3(r1(1,1),r1(1,2),r1(1,3),'+','Color',r2,'MarkerSize',4,'LineWidth',4),num2cell(P,2),num2cell(ColorSpec,2),'un',0);
set(gca, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], 'ZColor', [1 1 1]);
set(gcf,'Color',[0 0 0]);
colormap([0 1 1]);        
xlabel('X'), ylabel('Y'), zlabel('Z');
axis equal;
ax = gca;
ax.Clipping = 'off';
axis equal, axis tight;
alpha(0.5);