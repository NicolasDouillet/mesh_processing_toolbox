function [I, rc] = line_plane_intersection(u, N, n, M)
%% line_plane_intersection : function to compute the intersection point
% between the (N,u) line and the (M,n) plane of the 3D space.
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2023.
%
%
% Input arguments
%
% - u : real row or column vector double. numel(u) = 3. A director vector of the parametric line.
%
% - N : real row or column vector double. numel(N) = 3. A point belonging to the line.
%
% - n : real row or column vector double. numel(n) = 3. A normal vector to the plane.
%
% - M : real row or column vector double. numel(M) = 3. A point belonging to the plane.
%
% - verbose : either logical *true/false or integer *1/0. 
%
%
% Output arguments
%
% - I = [xI yI zI], real row or column vector double, the intersection point.
%
% - rc : return code, positive integer in the set {1,2,3}.
%        0 = void / [] intersection
%        1 = point intersection
%        2 = line intersection
%
%        rc return code is necessary to distinguish between cases where
%        (N,u) line and the (M,n) plane intersection is a single point
%        and where it is the line itself.


%% Body
% Plane offset parameter
d = -dot(n,M);

% Specific cases treatment
if ~dot(n,u) % n & u perpendicular vectors
    if dot(n,N) + d == 0 % N in P => line belongs to the plane        
        I = N;
        rc = 2;
    else % line // to the plane        
        I = [];
        rc = 0;
    end
else
    
    % Parametric line parameter t
    t = - (d + dot(n,N)) / dot(n,u);
    
    % Intersection coordinates
    I = N + u*t;
    
    rc = 1;
    
end


end % line_plane_intersection