% test reorient_all_faces_coherently

clc;

addpath(genpath('../../src'));
addpath('../../data');


load('icosahedron.mat');

for i = 1:size(T,1)
   
    if mod(i,2) == 0
        
        T(i,:) = fliplr(T(i,:));
        
    end
        
end

show_face_normals(V,T);
T = reorient_all_faces_coherently(V,T);
show_face_normals(V,T);