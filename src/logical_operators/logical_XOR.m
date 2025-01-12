function [T, V] = logical_XOR(T1, T2, V1, V2, precision)
%% logical_XOR : function to perform the logical exclusive union of two meshes.
% Ignore face / triangle orientation.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.
%
%
%%% Input arguments
%        
%        [ |   |   | ]
% - T1 = [i11 i12 i13], positive integer matrix double, the first input triangulation, size(T1) = [nb_triangles_1,3]. Mandatory.
%        [ |   |   | ]
%        
%        [ |  |  |]
% - V1 = [X1 Y1 Z1], real matrix double, the first input point set, size(V1) = [nb_vertices_1,3]. Mandatory argument.
%        [ |  |  |]
%
%        [ |   |   | ]
% - T2 = [i21 i22 i23], positive integer matrix double, the second input triangulation, size(T2) = [nb_triangles_2,3]. Mandatory.
%        [ |   |   | ]
%
%        [ |  |  |]
% - V2 = [X2 Y2 Z2], real matrix double, the second input point set, size(V2) = [nb_vertices_2,3]. Optional.
%        [ |  |  |]
%
% - precision, real positive scalar double, the precision used to compare X,Y,Z coordinate values between the two point sets V1 and V2. Mandatory only if V2.
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
    T = setxor(sort(T1,2),sort(T2,2),'rows');
    
elseif nargin > 3 % two distinct point sets
    
    if nargin > 4
        
        % Method : difference between OR and AND logical operators
        
        % Compute each one of the 2x2 sets
        [T_or,V_or]    = logical_OR(T1,T2,V1,V2, precision);
        [T_and,V_and] = logical_AND(T1,T2,V1,V2, precision);
        
        % Reindex AND triangulation based on OR one (AND being contained in OR)
        [~,or_id] = point_sets_intersection(V_or,V_and,precision);
        T_and = or_id(T_and);                      
        T = setdiff(sort(T_or,2),sort(T_and,2),'rows');             
        [V,T] = remove_unreferenced_vertices(V_or,T);                                                                                        
        
    elseif nargin < 5
        
        error('extra argument precision required to compare two different point sets.');
        
    end
    
end

% fprintf('Mesh exclusive union performed in %d seconds.\n',toc);


end % logical_XOR