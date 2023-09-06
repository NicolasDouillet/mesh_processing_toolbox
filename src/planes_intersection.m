function [I, u, rc] = planes_intersection(n1, M1, n2, M2)
%% planes_intersection : function to compute the intersection
% between P1(M1,n1) and P2(M2,n2) planes of the 3D space.
%
% Author & support : nicolas.douillet (at) free.fr, 2019-2023.

% Inputs arguments
%
% - M1 : real row or column vector double, a point belonging to P1. numel(M1) = 3.
%
% - n1 : real row or column vector double, one P1 normal vector. numel(n1) = 3.
%
% - M2 : real row or column vector double, a point belonging to P2. numel(M2) = 3.
%
% - n2 : real row or column vector double, one P2 normal vector. numel(n2) = 3.
%
%
% Output arguments
%
% - I : real vector double, one point belonging to the line intersection. size(I) = size(n1).
%
% - u : real vector double, one line director vector. size(u) = size(n1).
%
% - rc : return code, numeric integer in the set {1,2,3}.
%
% * 0 = void / [] intersection
% * 1 = line intersection,
% * 2 = plane intersection, P2 = P1
%
%        rc return code is necessary to distinguish between cases where P1 and P2 intersection
%        is a line and where it is the plane itself (P1 and P2 coincide).


%% Body
d1 = -dot(n1,M1); % -a1*x1 - b1*y1 - c1*z1
d2 = -dot(n2,M2); % -a2*x2 - b2*y2 - c2*z2

u = cross(n1,n2);

if norm(u) == 0 % (M1,n1) = (M2,n2) or (M1,n1) // (M2,n2)
   
    if (dot(n1,M2) + d1) == 0 && (dot(n2,M1) + d2) == 0 % (a1*M2(1) + b1*M2(2) + c1*M2(3) + d1) == 0                
        
        I = M1;
        u = M2 - M1;
        rc = 2;
        
    else                
        
        I = [];
        u = [];
        rc = 0;
        
    end
    
else 
          
     dir = find((abs(u) == max(abs(u))));     
     dir = dir(1);
     
     % => the line does exist in this direction, and then it can be set to t = 0.
     
     switch dir
         
         case 1 % setting : x = 0
             
             dx0y = (n1(3)*d2 - n2(3)*d1); % c1*d2 - c2*d1
             dx0z = (n2(2)*d1 - n1(2)*d2); % b2*d1 - b1*d2
             
             xI = 0;           
             yI = dx0y/u(1); 
             zI = dx0z/u(1);
             
         case 2 % setting : y = 0
             
             dxy0 = (n1(3)*d2 - n2(3)*d1); % c1*d2 - c2*d1
             dy0z = (n2(1)*d1 - n1(1)*d2); % a2*d1 - a1*d2
             
             xI = -dxy0/u(2);
             yI = 0;
             zI = -dy0z/u(2);
             
         case 3 % setting : z = 0
             
             dxz0 = (n1(2)*d2 - n2(2)*d1); % b1*d2 - b2*d1
             dyz0 = (n2(1)*d1 - n1(1)*d2); % a2*d1 - a1*d2
             
             xI = dxz0/u(3);
             yI = dyz0/u(3);
             zI = 0;                         
             
     end
     
     I = zeros(size(M1));
     I(1) = xI;
     I(2) = yI;
     I(3) = zI;
     
     rc = 1;
     
end


end % planes_intersection