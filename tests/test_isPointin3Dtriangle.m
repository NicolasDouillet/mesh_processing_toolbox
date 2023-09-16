% test isPointin3Dtriangle

clear all, close all, clc;

addpath('../src');
addpath('../data');


A = [1 0 0];
B = [0 1 0];
C = [0 0 1];

P1 = ones(1,3)/3;

isP1inABC = isPointin3Dtriangle(A,B,C,P1) % P1 € (ABC)

P2 = 0.5*ones(1,3); 

isP2inABC = isPointin3Dtriangle(A,B,C,P2) % P2 not in (ABC)

% Closed set : boundary inlcuded
isAinABC = isPointin3Dtriangle(A,B,C,A)
isBinABC = isPointin3Dtriangle(A,B,C,B)
isCinABC = isPointin3Dtriangle(A,B,C,C)


P4 = 0.25*(A+B) + 0.5*C; % linear combination (total weights = 1)
isP4inABC = isPointin3Dtriangle(A,B,C,P4) % P4 € (ABC)

P5 = 0.5*(A+B); % linear combination (total weights = 1)
isP5inABC = isPointin3Dtriangle(A,B,C,P5) % P5 € (ABC)

M = [1 -1 -1];
N = [-1 -1 -1];
P = [0 1 1];

isOinMNP = isPointin3Dtriangle(M,N,P,[0 0 0]) % O € (MNP)

P6 = [1 1 0];
isP6inMNP = isPointin3Dtriangle(M,N,P,P6) % P6 not in (MNP)





