function V_out = smooth_mesh(V_in, T, nb_iterations, ngb_degre)
%% smooth_mesh : function to smooth the mesh following Laplace
% technique.
%
% Basic working principle : each vertex coordinate is replace by 
% the mean of its neighbors. The number of vertices stays the same.
%
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
% 
% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], double matrix, the input point set, size(V_in) = [nb_input_vertices,3].
%          [ |    |    |  ]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
% - nb_iterations : positive integer, the number of smoothing iterations to perform on the mesh.
%
% - ngb_degre : positive integer scalar in the range |[1; 6]|, the neighbor degre. Default value is 1.
%
%
% Output argument
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], double matrix, the output point set, size(V_out) = [nb_output_vertices,3].
%           [  |     |     |  ]


%% Body
tic;

if nargin < 4
    
   ngb_degre = 1;
    
end

% I Get vertex neighbors
V_out = V_in;

if ngb_degre < 2
    
    neighbor_list = find_every_vertices_neighbor_indices(T,ngb_degre);
    
else % if ngb_degre > 1
   
    neighbor_list = find_every_vertices_neighbor_indices(T,ngb_degre,size(V_in,1));
    
end

for k = 1:nb_iterations
    
    % Basic mean on vertex neighbors
    V_out = cell2mat(cellfun(@(r) sum(V_out(r,:),1)/numel(r),neighbor_list,'un',0));
    
end

fprintf('Laplacian mesh smoothed in %d seconds.\n',toc);


end % smooth_mesh