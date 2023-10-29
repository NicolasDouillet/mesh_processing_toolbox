function isin = isPointin3Dtriangle(A, B, C, P) % row vectors 1 x 3 % is3DPointonPlane(n, M, P)
%
% Author & support : nicolas.douillet (at) free.fr, 2023.

% Boundary included


epsilon = eps;

% Unitary line director vectors
uAB = B-A;
uAB = uAB/norm(uAB);
uAC = C-A;
uAC = uAC/norm(uAC);
uBC = C-B;
uBC = uBC/norm(uBC);

% Vertex normals (outward oriented)
nA = -uAB - uAC;
nB =  uAB - uBC;
nC =  uBC + uAC;

% Edge normals (outward oriented)
mAB = nA + nB;
mAC = nA + nC;
mBC = nB + nC;

% Check P belongs to (ABC) plane
nABC = cross(uAB,uAC);
nABC = nABC / norm(nABC);
d = -nABC(1)*A(1) - nABC(2)*A(2) - nABC(3)*A(3);

% First logical condition
c1 = abs(nABC(1)*P(1) + nABC(2)*P(2) + nABC(3)*P(3) + d) < epsilon;

I_AB = 0.5*(A+B);
I_BC = 0.5*(B+C);
I_AC = 0.5*(A+C);

sgn_dot_prod_A = dot(nA,A-P,2) > -epsilon;
sgn_dot_prod_B = dot(nB,B-P,2) > -epsilon;
sgn_dot_prod_C = dot(nC,C-P,2) > -epsilon;

sgn_dot_prod_AB = dot(mAB,I_AB-P,2) > -epsilon;
sgn_dot_prod_AC = dot(mAC,I_AC-P,2) > -epsilon;
sgn_dot_prod_BC = dot(mBC,I_BC-P,2) > -epsilon;

% Second logical condition
c2 = numel(find([sgn_dot_prod_A,sgn_dot_prod_B,sgn_dot_prod_C,sgn_dot_prod_AB,sgn_dot_prod_AC,sgn_dot_prod_BC])) > 5;


isin = c1 & c2;
end % isPointin3Dtriangle