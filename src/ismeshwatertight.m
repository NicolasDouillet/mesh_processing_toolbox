function b = ismeshwatertight(V, T, surf_type)
%% ismeshwatertight : Boolean state function to test
% if the surface is watertight or not.
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2023.
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
% - surf_type : character string in the set {'closed','opened','CLOSED','OPENED'},
%               the type of surface considered. Case insensitive.
%
%
% Output argument
%
% - b : logical true/false | 1/0, the watertightness result.


%% Body
tic;
assert(nargin > 1,'Error, not enough input arguments.');

[~,T] = remove_isolated_triangles(V,T,true);
boundaries = detect_mesh_boundaries_and_holes(T);

if strcmpi(surf_type,'closed')
    
    b = isempty(boundaries);
    
    if b
        
        fprintf('No hole detected on a closed surface. Mesh is watertight.\n');
        
    else
        
        fprintf('%d hole(s) detected on a closed surface. Mesh is not watertight.\n',size(boundaries,1));
        
    end
    
elseif strcmpi(surf_type,'opened')
    
    b = size(boundaries,1) < 2;
    
    if b
        
        fprintf('No more than one boundary detected on an opened surface. Mesh is watertight.\n');
        
    else
        
        fprintf('%d hole(s) (>1) detected on an opened surface. Mesh is not watertight.\n',size(boundaries,1));
        
    end
    
end

fprintf('iswatertight request executed in %d seconds.\n',toc);


end % ismeshwatertight