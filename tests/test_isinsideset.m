% test isinsideset

clear all, close all, clc;

addpath('../src');
addpath('../data');


% Closed watertight 2D-manifold triangulated surfaces only
filenames = {'sinusoidal_dodecahedron_MR';...
             'concave_Reuleaux_tetrahedron';...
             'kitten';...
             'Armadillo_10k';...                                                            
             'vase'
             };

id = 1; % 1, 2, 3, 4, 5      
filename = strcat(cell2mat(filenames(id,1)),'.mat');         
load(filename);


% When necessary; see and download mesh processing toolbox
% https://fr.mathworks.com/matlabcentral/fileexchange/77004-mesh-processing-toolbox?s_tid=prof_contriblnk
%
% [V,T] = remove_duplicated_vertices(V,T); 
% T     = remove_duplicated_triangles(T);
% [V,T] = remove_non_manifold_vertices(V,T);
% T     = remove_non_manifold_triangles(T);
% T     = reorient_all_faces_coherently(V,T);
% ni    = compute_vertex_normals(V,T);
% select_face_normals(V,T); % to check normals orientation


% Vertex normals
G = mean(V,1);
nb_vtx = size(V,1);
ni = zeros(nb_vtx,3);

for i = 1:nb_vtx    
    tgl_idx_list = find(sum(ismember(T,i),2));
    vtx_ngb_face_normals = compute_face_normals(V,T(tgl_idx_list,:));
    ni(i,:) = mean(vtx_ngb_face_normals,1);        
end

ni = ni./sqrt(sum(ni.^2,2));
orientation = sign(dot(ni,V-repmat(G,[nb_vtx,1]),1)); % Coherently orient outward vertex normals

if ~isequal(orientation,ones(nb_vtx,1))     
    ni = ni.*orientation;
end


% % Setting test points
%
% % I Regularly sampled grid test    
% nb_samples = 11;
% [A,B,C] = meshgrid(linspace(min(V(:,1)),max(V(:,1)),nb_samples),...
%                    linspace(min(V(:,2)),max(V(:,2)),nb_samples),...
%                    linspace(min(V(:,3)),max(V(:,3)),nb_samples));
%           
% P = cat(2,A(:),B(:),C(:));
%
%
% % II Boundary belonging test
% P = V;
%
%
% III Boundary random arounds tests 
S = max(V(:,3)-min(V(:,3)));
P = V + 0.1*S*(rand(nb_vtx,3)-0.5); % boundary + small noise test
%
%
% % IV Boundary normal direction tests
% P = V + 0.005*S*ni; % boundary +/- normal vector direction translated vertices test ('-' is inside; '+' is outside)


tic
[isin,V,T] = isinsideset(V,T,P);
toc

disp('Total number of points :');
size(V,1)

disp('Number of inside points :');
nnz(isin)

disp('Number of outside points :');
nnz(~isin)


h = figure;
set(h,'Position',get(0,'ScreenSize'));
trisurf(T,V(:,1),V(:,2),V(:,3)), shading faceted, hold on;

% % Inside and outside points together
% ColorSpec = cell2mat(cellfun(@(c) cat(2,~c,c,0),num2cell(isin,2),'un',0));
% cellfun(@(r1,r2) plot3(r1(1,1),r1(1,2),r1(1,3),'+','Color',r2,'MarkerSize',4,'LineWidth',4),num2cell(P,2),num2cell(ColorSpec,2),'un',0);

% Inside points only
ColorSpec = cell2mat(cellfun(@(c) c,num2cell(isin > 0 ,2),'un',0));
cellfun(@(r) plot3(r(1,1),r(1,2),r(1,3),'+','Color',[0 1 0],'MarkerSize',4,'LineWidth',4),num2cell(P(isin,:),2),'un',0);

% % Outside points only
% ColorSpec = cell2mat(cellfun(@(c) c,num2cell(isin < 1 ,2),'un',0));
% cellfun(@(r) plot3(r(1,1),r(1,2),r(1,3),'+','Color',[1 0 0],'MarkerSize',4,'LineWidth',4),num2cell(P(~isin,:),2),'un',0);

set(gca, 'Color', [0 0 0], 'XColor', [1 1 1], 'YColor', [1 1 1], 'ZColor', [1 1 1]);
set(gcf,'Color',[0 0 0]);
colormap([0 1 1]);        
xlabel('X'), ylabel('Y'), zlabel('Z');
axis equal;
ax = gca;
ax.Clipping = 'off';
axis equal, axis tight;
shading flat;
camlight left
alpha(1);