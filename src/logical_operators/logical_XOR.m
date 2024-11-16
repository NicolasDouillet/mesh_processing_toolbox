function [T, V] = logical_XOR(T1, T2, V1, V2, precision)
% logical_XOR : function to perform the logical exclusive union of two meshes.
%
%%% Author : nicolas.douillet (at) free.fr, 2024.
%
%
%%% Input arguments
%        
%        [ |   |   | ]
% - T1 = [i11 i12 i13], positive integer matrix double, the first input triangulation, size(T1) = [nb_triangles_1,3].
%        [ |   |   | ]
%        
%        [ |  |  |]
% - V1 = [X1 Y1 Z1], real matrix double, the first input point set, size(V1) = [nb_vertices_1,3].
%        [ |  |  |]
%
%        [ |   |   | ]
% - T2 = [i21 i22 i23], positive integer matrix double, the second input triangulation, size(T2) = [nb_triangles_2,3].
%        [ |   |   | ]
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


% Body
% tic;

if nargin < 4 % one unique point set
    
    V = V1;
    T = setxor(sort(T1,2),sort(T2,2),'rows');
    
elseif nargin > 3 % two distinct point sets
    
    if nargin > 4
        
        V = point_sets_xor(V1,V2,precision);
        
        % Retrouver et ajouter les 3e points liés dans les triangles
        % de la triangulation correspondante !
        
        T = [];
        
        %         [T_AND,V_AND] = logical_AND(T1,T2,V1,V2,precision);
        %         [T_OR,V_OR]   = logical_OR(T1,T2,V1,V2,precision);
        %         T = setdiff(sort(T_OR,2),sort(T_AND,2),'rows');
        %
        %         % PAS DU TOUT !
        %         % AUCUNE CHANCE QUE L'ORDRE SOIT RESPECTE ICI !
        %         % NECESSITE D4AUTRES TRAITEMENTS SUPPLEMENTAIRES SUR LES POINTS
        %
        %         V = setdiff(V_OR,V_AND,'rows','stable'); % doesn't work if the two triangulations actually are identical / the same
        
    elseif nargin < 5
        
        error('extra argument precision required to compare two different point sets.');
        
    end
    
end

% fprintf('Mesh exclusive union performed in %d seconds.\n',toc);


end % logical_XOR