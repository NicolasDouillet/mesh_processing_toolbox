% test convex_hull

clc;

addpath(genpath('../../src'));
addpath('../../data');


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


% filenames = {'tetrahedron';...
%              'cube';...             
%              'octahedron';...
%              'icosahedron';...   
%              'dodecahedron_trimesh_optim';
%              'geoid_lvl4';...
%              'ovoid_LR';...
%              'Reuleaux_tetrahedron_light';...
%              'Reuleaux_tetrahedron';...
%              'sinusoidal_dodecahedron_MR';...
%              'concave_Reuleaux_tetrahedron';...
%              'torus_light';...
%              };
% 
% id = 6;
% filename = strcat(cell2mat(filenames(id,1)),'.mat');         
% load(filename); 
% V = unique(V,'rows');


T_cv          = convhull(V);    % Matlab (R) embeded function
T_mcv         = convex_hull(V); % my Jarvis / gift wrapping algorithm
[V_out,T_qcv] = quick_hull(V);  % my quickhull algorithm


if isequal(sortrows(sort(T_mcv,2)),sortrows(sort(T_cv,2))) % no test with T_qcv since V_out and then triangulations are different
   
    disp('Same point sets and triangulations.');
    
else
    
    disp('Point sets and triangulations are different, possibly due to some coplanar points.');
    
end


show_face_normals(V,T_cv);
axis equal;

show_face_normals(V,T_mcv);
axis equal;

show_face_normals(V_out,T_qcv);
axis equal;