% test reorient_all_faces_coherently

clear all, close all, clc;

addpath('../src');
addpath('../data');


% % load('randoriented_ico.mat');
% 
% select_face_normals(V,T);
% T = reorient_all_faces_coherently(V,T);
% 
% T = flip_faces_orientation(T); % if necessary
% select_face_normals(V,T);


load('vase.mat');


for i = 1:size(T,1)
   
    if mod(i,2) == 0
        
        T(i,:) = fliplr(T(i,:));
        
    end
        
end

T = reorient_all_faces_coherently(V,T); % works ok
select_face_normals(V,T);