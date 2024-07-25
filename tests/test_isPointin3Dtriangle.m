% test isPointin3Dtriangle

clc;

addpath(genpath('../src'));
addpath('../data');


A = [1 0 0];
B = [0 1 0];
C = [0 0 1];

% Single points
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


% Array of points
N = 2^11;
M = cat(2,2*sqrt(2)*(rand(N,2)-0.5)/sqrt(3),(1/sqrt(3))*ones(N,1));
Rho = sqrt(sum(M(:,1:2).^2,2));
i = Rho <= 0.5*sqrt(3);
M = M(i,:);


u = cross([0 0 1],[1 1 1]/3,2);
u = u/norm(u);

theta = acos(1/sqrt(3));

Rmu = [u(1)^2+cos(theta)*(1-u(1)^2) (1-cos(theta))*u(1)*u(2)-u(3)*sin(theta) (1-cos(theta))*u(1)*u(3)+u(2)*sin(theta);
       (1-cos(theta))*u(1)*u(2)+u(3)*sin(theta) u(2)^2+cos(theta)*(1-u(2)^2) (1-cos(theta))*u(2)*u(3)-u(1)*sin(theta);
       (1-cos(theta))*u(1)*u(3)-u(2)*sin(theta) (1-cos(theta))*u(2)*u(3)+u(1)*sin(theta) u(3)^2+cos(theta)*(1-u(3)^2)];
               
                       
P = (Rmu*M')';           

isPinABC = isPointin3Dtriangle(A,B,C,P);


for k = 1:size(P,1)
   
    if isPinABC(k)
        
        plot3(P(k,1),P(k,2),P(k,3),'.','Color',[0 1 0]), hold on;
    
    elseif isPinABC(k) == false 
       
        plot3(P(k,1),P(k,2),P(k,3),'.','Color',[1 0 0]), hold on;
        
    end
    
end

line([1 0 0 1],[0 1 0 0],[0 0 1 0],'Color',[1 0 0],'LineWidth',2), hold on;


xlabel('X');
ylabel('Y');
zlabel('Z');
axis square, axis equal;
grid on, box on;