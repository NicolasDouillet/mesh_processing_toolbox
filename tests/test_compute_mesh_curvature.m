% test compute_mesh_curvature

clear all, close all, clc;

addpath('../src');
addpath('../data');

% load('log_spiral.mat');
% load('Archimede_spiral');
% load('Fermat_spiral.mat');
% load('Reuleaux_tetrahedron.mat');
% load('sinico.mat');
% load('sinus_dodeca.mat');
% load('torus.mat');
load('kitten.mat');
% load('Gargoyle_5k.mat');
% load('Armadillo_10k.mat');

ngb_degre = 1;

N = compute_vertex_normals(V,T,ngb_degre,'raw');
curvature = compute_mesh_curvature(V,T,N,ngb_degre,'mean');
show_mesh_curvature(V,T,curvature);