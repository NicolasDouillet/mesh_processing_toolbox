% test dihedral_angle

clc;

addpath(genpath('../../src'));
addpath('../../data');


% filename = 'tetrahedron';  % acos(1/3)° = 70.5288° only for all dihedral angles
% filename = 'cube';         % either 90° or 0° angles only
filename = 'octahedron';   % 109.4693° only for all dihedral angles
% filename = 'icosahedron';  % 138.1897° only for all dihedral angles
% filename = 'dodecahedron'; % acos(-1/sqrt(5))° = 116.5651° only for all dihedral angles


load(strcat(filename,'.mat'));
N = face_normals(V,T);
face_ids = 1:size(T,1);
E = query_edg_list(T);
dha = dihedral_angle(T,N,E);
% dha = dha(~isinf(dha));
dha_deg = 180*dha/pi