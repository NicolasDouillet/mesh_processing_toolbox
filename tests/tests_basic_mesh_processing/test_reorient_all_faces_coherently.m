% test reorient_all_faces_coherently

clc;

addpath(genpath('../../src'));
addpath('../../data');


% Test with Fermat spiral


load('randoriented_ico.mat');

show_face_normals(V,T);
T = reorient_all_faces_coherently(V,T);
T = flip_faces_orientation(T); % if necessary
show_face_normals(V,T);


% load('vase.mat');
% 
% for i = 1:size(T,1)
%    
%     if mod(i,2) == 0
%         
%         T(i,:) = fliplr(T(i,:));
%         
%     end
%         
% end
% 
% show_face_normals(V,T);
% T = reorient_all_faces_coherently(V,T);
% show_face_normals(V,T);