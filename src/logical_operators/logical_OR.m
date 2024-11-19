function [T, V] = logical_OR(T1, T2, V1, V2, precision)
%% logical_OR : function to perform the logical union of two meshes.
% Ignore face / triangle orientation.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%        
%        [ |   |   | ]
% - T1 = [i11 i12 i13], positive integer matrix double, the first input triangulation, size(T1) = [nb_triangles_1,3].
%        [ |   |   | ]
%
%        [ |   |   | ]
% - T2 = [i21 i22 i23], positive integer matrix double, the second input triangulation, size(T2) = [nb_triangles_2,3].
%        [ |   |   | ]
%        
%        [ |  |  |]
% - V1 = [X1 Y1 Z1], real matrix double, the first input point set, size(V1) = [nb_vertices_1,3].
%        [ |  |  |]
%
%        [ |  |  |]
% - V2 = [X2 Y2 Z2], real matrix double, the second input point set, size(V2) = [nb_vertices_2,3].
%        [ |  |  |]
%
% - precision, real positive scalar double, the precision used to compare X,Y,Z coordinate values between the two point sets V1 and V2.
%   Optional but mandatory if V2.
%
%
%%% Output arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the output point set, size(V) = [nb_vertices,3],
%       [| | |]
%
%       with nb_vertices = nb_vertices_1 + nb_vertices_2.
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the output triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%       with nb_triangles = nb_triangles_1 + nb_triangles_2.


%% Body
% tic;

if nargin < 4 % one unique point set
    
    V = V1;
    T = cat(1,T1,T2 + size(V,1));    
    
elseif nargin > 3 % two distinct point sets
    
    if nargin > 4
        
    V = cat(1,V1,V2);
    T = cat(1,T1,T2 + size(V1,1));    
    [V,T] = remove_duplicated_vertices(V,T,precision);
    
    elseif nargin < 5
       
        error('extra argument precision required to compare two different point sets.');
        
    end
    
end

T = remove_duplicated_triangles(T);

% fprintf('Meshes union performed in %d seconds.\n',toc);


end % logical_OR