function T_out = add_triangles(T_set, T_in)
%% add_triangles : function to add new triangles to the triangle set.
% If one or more vertices are new, they must be added first in the vertex set
% for the triangulation to be valid.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
% Input arguments
%
%           [|  |  | ]
% - T_set = [i1 i2 i3], positive integer matrix double, the triangle set to add, size(T_set) = [nb_new_triangles,3].
%           [|  |  | ]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
%
% Output arguments
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3],
%           [  |      |      |   ]
%
%           with nb_output_triangles = nb_input_triangles + nb_new_triangles.


%% Body
% tic;

% Check if vertices id are valid
if T_set > 0 & isreal(T_set) & rem(T_set,1) == 0 & floor(T_set) == T_set
    
    % Check if some triangles of T_set already part of T_in
    dpl_tgl_idx = ismember(sort(T_set,2),sort(T_in,2),'rows');               
                        
    if nnz(dpl_tgl_idx)                
        
        % Suppress duplicated triangles
        T_set = T_set(~dpl_tgl_idx,:);             
        % warning('One or more triangle from this set already exist in the current triangulation. Duplicated triangles have been ignored.\n');
        
    end
    
    T_out = cat(1,T_in,T_set);
    % fprintf('%d triangles added in %d seconds.',size(T_set,1),toc);
    
else
    
    error('Unable to perform triangles addition because T_set contains some invalid vertex indices. Vertex indices must be positive integers in the range |[1; number of vertices of the vertex set]|.\n');
    
end


end % add_triangles