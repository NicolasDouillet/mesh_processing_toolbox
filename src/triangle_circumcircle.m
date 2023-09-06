function [R, I, r] = triangle_circumcircle(A, B, C, nb_samples)
%% triangle_circumcircle : function to compute and display the circumcircle of one given triangle
%
% Author & support : nicolas.douillet (at) free.fr, 2022-2023.
%
% Syntax
%
% triangle_circumcircle(A, B, C);
% triangle_circumcircle(A, B, C, nb_samples);
% triangle_circumcircle(A, B, C, nb_samples, option_display);
% [R, I, r] = triangle_circumcircle(A, B, C, nb_samples, option_display);
%
% Description
%
% triangle_circumcircle(A, B, C) computes and displays the circumcircle of ABC triangle.
% triangle_circumcircle(A, B, C, nb_samples) uses nb_samples to draw the circle.
% triangle_circumcircle(A, B, C, nb_samples, option_display) displays the circle when option_display is set either to
% logical true or real numeric 1, and doesn't when it is set to logical false or real numeric 0.
% [R, I, r] = triangle_circumcircle(A, B, C, nb_samples, option_display) stores the results in [R, I, r] vector.
%
% See also CIRCUMCENTER INCENTER
%
% Input arguments
%
%       [Ax]
% - A = [Ay] : real column vector double. 2 <= numel(A) <= 3. One of the three ABC vertices. 
%       [Az]
%
%       [Bx]
% - B = [By] real column vector double. 2 <= numel(A) <= 3. One of the three ABC vertices.
%       [Bz]
%
%       [Cx]
% - C = [Cy] real column vector double. 2 <= numel(A) <= 3. One of the three ABC vertices.
%       [Cz]
%
% - nb_samples : integer scalar double. The number of samples to draw the
%                circumcircle. nb_samples >= 3.
%
%
% Output arguments
%
%       [- Rx -]
% - R = [- Ry -]: real matrix double. The circumcircle coordinates. size(R) = [size(A,1), nb_samples].
%       [- Rz -]
%
%       [Ix]
% - I = [Iy] : real column vector double. 2 <= numel(I) <= 3. The circumcircle centre.
%       [Iz]
%
% - r : real scalar double. the circumcircle radius.


%% Body
dimension = numel(A);

if dimension < 3 % one padding in 2D case    
    
    A = cat(1,A,1);
    B = cat(1,B,1);
    C = cat(1,C,1);
    
end

% ABC triangle director and normal vectors computation 
AB = (B-A)/norm(B-A);
AC = (C-A)/norm(C-A);
n = cross(AB,AC);

% AB and AC segment mediatrices computation
I_AB = 0.5*(A+B);
I_AC = 0.5*(A+C);

% Circle centre I computation
[D,u] = planes_intersection(AB,I_AB,AC,I_AC); 
I = line_plane_intersection(u,D,n,A);

% Circle radius r computation
r = norm(I-A);

% Compute the circle point coordinates
angle_step = 2*pi/nb_samples;
theta = linspace(0,2*pi-angle_step,nb_samples);

Cx = r*cos(theta);
Cy = r*sin(theta);
Cz = zeros(1,nb_samples);


if dimension > 2
    
    % Vector u to rotate around
    k = [0 0 1]';
    u = cross(k,n)/norm(cross(k,n));
    
    % Angle between k and u
    alpha = atan2(norm(cross(k,n)),dot(k,n));
    
    % 3D rotation matrix around u vector
    Rm = @(delta)[u(1,1)^2+cos(delta)*(1-u(1,1)^2) (1-cos(delta))*u(1,1)*u(2,1)-u(3,1)*sin(delta) (1-cos(delta))*u(1,1)*u(3,1)+u(2,1)*sin(delta);
                  (1-cos(delta))*u(1,1)*u(2,1)+u(3,1)*sin(delta) u(2,1)^2+cos(delta)*(1-u(2,1)^2) (1-cos(delta))*u(2,1)*u(3,1)-u(1,1)*sin(delta);
                  (1-cos(delta))*u(1,1)*u(3,1)-u(2,1)*sin(delta) (1-cos(delta))*u(2,1)*u(3,1)+u(1,1)*sin(delta) u(3,1)^2+cos(delta)*(1-u(3,1)^2)];
    
    R = (Rm(alpha) * cat(1,Cx,Cy,Cz))' + I';
    
else % if dimension == 2
    
    R = cat(1,Cx,Cy,Cz)' + I';
    
    % one simplifications in 2D case
    R = R(:,1:2); 
    I = I(1:2);
    
end


end % triangle_circumcircle