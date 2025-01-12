function b = ismeshwatertight(V, T, surf_type)
%% ismeshwatertight : Boolean state function to test
% if the surface is watertight or not.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3]. Mandatory.
%       [|  |  | ]
%
% - surf_type : character string in the set {'closed','opened','CLOSED','OPENED'},
%               the type of surface considered. Case insensitive. Mandatory.
%
%
%%% Output argument
%
% - b : logical true/false | 1/0, the watertightness result.


%% Input parsing & body
tic;

if nargin < 2
    
    error('Not enough input arguments.');
    
end

[~,T] = remove_isolated_triangles(V,T,true);
boundary = detect_mesh_boundary_and_holes(T);

if strcmpi(surf_type,'closed')
    
    b = isempty(boundary);
    
    if b
        
        fprintf('No hole detected on a closed surface. Mesh is watertight.\n');
        
    else
        
        fprintf('%d hole(s) detected on a closed surface. Mesh is not watertight.\n',size(boundary,1));
        
    end
    
elseif strcmpi(surf_type,'opened')
    
    b = size(boundary,1) < 2;
    
    if b
        
        fprintf('No more than one boundary detected on an opened surface. Mesh is watertight.\n');
        
    else
        
        fprintf('%d hole(s) (>1) detected on an opened surface. Mesh is not watertight.\n',size(boundary,1));
        
    end
    
end

fprintf('iswatertight request executed in %d seconds.\n',toc);


end % ismeshwatertight