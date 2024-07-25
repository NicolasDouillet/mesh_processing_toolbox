function N = face_normals(V, T, mode)
%% face_normals : function to compute faces (triangles) normals.
%
% Author : nicolas.douillet9 (at) gmail.com, 2020-2024.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [|  |  | ]
%
% - mode : character string in the set : {'raw','norm'*,'RAW','NORM'}, the variable deciding
%          wether to normalize or not the face normals. Case insensitive.
%
%
% Output argument
%
%       [ |  |  |]
% - N : [Nx Ny Nz], real matrix double, the face normal vectors, size(N) = [nb_triangles,3].
%       [ |  |  |]


% tic;


%% Input parsing and parameters default values
if nargin < 3
   
    mode = 'norm';
    
end


%% Body
N = cross(V(T(:,2),:)-V(T(:,1),:),V(T(:,end),:)-V(T(:,1),:),2);

if strcmpi(mode,'norm')
    
    N = N./sqrt(sum(N.^2,2));
    
    % elseif strcmpi(mode,'raw')
    
    % do nothing
    
end

% fprintf('Face normals computed in %d seconds.\n',toc);


end % face_normals