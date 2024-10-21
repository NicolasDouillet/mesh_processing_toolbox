function [d2H, H] = point_to_line_distance(P, u, I0)
%% point_to_line_distance : function to compute the distance
% between the 3D point P and the line (I0,u) in the 3D space,
% and the coordinates of its projection, H.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
% Input arguments
%
%       [|  |  | ]
% - P : [Px Py Pz], real matrix double, point or list of N points which
%       [|  |  | ]
%       
%       we want the distance to the 3D line. size(P) = [N,3].
%
% - u = [ux uy uz], real row vector double, a vector guiding the line. size(u) = [1,3].
%
% - I0 = [I0x I0y I0z], real row vector double, size(I0) = [1,3], a known point belonging to the line.
%
%
% Output argument
%
% - d2H : real scalar double or vector double, the euclidian distance between P and the line (I0,u). size(d2H) = [N,1].      
%              
%       [|  |  | ]
% - H : [xH yH zH], real matrix double, the point projected on the line, size(H) = [N,3].
%       [|  |  | ]


%% Body
[nb_pts, nbdim] = size(P);

if nbdim == 2
    
    t_H = (u(1)*(P(:,1)-repmat(I0(1),[nb_pts,1])) + ...
           u(2)*(P(:,2)-repmat(I0(2),[nb_pts,1]))) / ...
           sum(u.^2);
    
elseif nbdim == 3
    
    t_H = (u(1)*(P(:,1)-repmat(I0(1),[nb_pts,1])) + ...
           u(2)*(P(:,2)-repmat(I0(2),[nb_pts,1])) + ...
           u(3)*(P(:,3)-repmat(I0(3),[nb_pts,1])) ) / ...
           sum(u.^2);

end

% Distance
H = I0 + t_H*u;
d2H = sqrt(sum((P-H).^2,2));


end % point_to_line_distance