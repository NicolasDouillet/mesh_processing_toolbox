function [d2H, H] = point_to_plane_distance(M, n, I)
%% point_to_plane_distance : function to compute the distance between
% the 3D point M and the plane (I,n). Also provides the coordinates
% of H, the projection of M on (I,n), and also works for a list of points.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%
%       [|  |  | ]
% - M = [Mx My Mz] real row vector/matrix double, the point -or list of N points- which
%       [|  |  | ]
%
%       we want the distance to the plane. size(M) = [N,3].
%
% - n = [nx ny nz], real row vector double, a plane normal vector, size(n) = [1,3].
%
% - I = [Ix Iy Iz], real row vector double, a point belonging to the plane, size(I) = [1,3].
%
% 
%%% Output arguments
%
% - d2H : real scalar -or vector- double, the euclidian distance between M and the plane (I,n). size(d2H) = [N,1].
% - H : real vector double, the projected point(s) on the plane. size(H) = [N,3].


%% Body
nb_pts = size(M,1);
d_I = -(n(1)*I(1)+n(2)*I(2)+n(3)*I(3));
t_H = -(repmat(d_I,[nb_pts,1])+n(1)*M(:,1)+n(2)*M(:,2)+n(3)*M(:,3)) / sum(n.^2);

x_H = M(:,1) + t_H*n(1);
y_H = M(:,2) + t_H*n(2);
z_H = M(:,3) + t_H*n(3);

% Orthogonal projected point
H = cat(2,x_H,y_H,z_H);
d2H = sqrt(sum((M-H).^2,2));


end % point_to_plane_distance