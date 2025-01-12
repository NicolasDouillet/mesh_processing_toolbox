function isin = isPointin3Dtriangle(A, B, C, P) % row vectors 1 x 3 % is3DPointonPlane(n, M, P)
%% isPointin3Dtriangle : function to check if a point P of the 3D space is
% included in a given ABC triangle, including its boundary.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2023-2025.
%
%
%%% Input arguments
%
% - A = [Ax Ay Az], real row vector double, the triangle first point. size(A) = [1,3]. Mandatory.
%
% - B = [Bx By Bz], real row vector double, the triangle second point. size(B) = [1,3]. Mandatory. 
%
% - C = [Cx Cy Cz], real row vector double, the triangle third point. size(C) = [1,3]. Mandatory.
%
% - P = [Px Py Pz], real row vector double, the  point to test. size(P) = [1,3]. Mandatory. 
%
%
%%% Output argument
%
% - isin : logical true/false | 1/0, the result.


%% Body
epsilon = 1e3*eps;

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
c1 = abs(nABC(1)*P(:,1) + nABC(2)*P(:,2) + nABC(3)*P(:,3) + d) < epsilon;

I_AB = 0.5*(A+B);
I_BC = 0.5*(B+C);
I_AC = 0.5*(A+C);

sgn_dot_prod_A = dot(repmat(nA,[size(P,1),1]),A-P,2) > -epsilon;
sgn_dot_prod_B = dot(repmat(nB,[size(P,1),1]),B-P,2) > -epsilon;
sgn_dot_prod_C = dot(repmat(nC,[size(P,1),1]),C-P,2) > -epsilon;

sgn_dot_prod_AB = dot(repmat(mAB,[size(P,1),1]),I_AB-P,2) > -epsilon;
sgn_dot_prod_AC = dot(repmat(mAC,[size(P,1),1]),I_AC-P,2) > -epsilon;
sgn_dot_prod_BC = dot(repmat(mBC,[size(P,1),1]),I_BC-P,2) > -epsilon;

% Second logical condition
c2 = sum(cat(2,sgn_dot_prod_A,sgn_dot_prod_B,sgn_dot_prod_C,sgn_dot_prod_AB,sgn_dot_prod_AC,sgn_dot_prod_BC),2) > 5;


isin = c1 & c2;
end % isPointin3Dtriangle