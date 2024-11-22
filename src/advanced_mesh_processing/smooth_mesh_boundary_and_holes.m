function V_out = smooth_mesh_boundary_and_holes(V_in, boundaries, nb_iterations, ngb_degre, hole_ids)
%% smooth_mesh_boundary_and_holes : function to smooth the mesh boundaries, without
% renormalization. To avoid singularities creation, remove small components
% and close small holes before smoothing.
%
% Basic working principle : each boundary vertex is replace by
% the mean of its neighbors. The number of boundary vertices stays the same
% and no connectivity change happen in the mesh.
%
%
%%% Author : nicolas.douillet (at) free.fr, 2021-2024.
%
%
%%% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], double matrix, the input point set, size(V_in) = [nb_input_vertices,3].
%          [ |    |    |  ]
%
% - boundaries : cell array of positive integer row vectors double, size(boundaries) = [nb_holes,1].
%
% - nb_iterations : positive integer, the number of smoothing iterations to perform on the mesh boundaries.
%
% - ngb_degre : positive integer scalar in the range |[1; 6]|, the neighbor degre. Default value is 1.
%
% - hole_ids : positive integer vector double, vector of the holes ids.
%
%
%%% Output argument
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], double matrix, the output point set, size(V_out) = [nb_output_vertices,3].
%           [  |     |     |  ]


%% Body
tic;

if nargin < 5
   
    hole_ids = 1:size(boundaries,1);
    
end

boundaries = boundaries(hole_ids,1);
V_out = V_in;
nb_bound = size(boundaries,1);

% Loop on boundaries
for i = 1:nb_bound
    
    % Current boundary
    boundary = cell2mat(boundaries(i,1));
    raw_vtx_bound = V_in(boundary,:);
    smoothed_bound_vtx = zeros(size(raw_vtx_bound));        
    
    % boundary_neighbor_list = cell2mat( cellfun(@(r) circshift(boundary,-r)',circshift(boundary,r)',num2cell(1:ngb_degre),'un',0) );
    boundary_neighbor_list = zeros(numel(boundary),0);
    
    % TODO : with cellfun
    for j = 1:ngb_degre       
        boundary_neighbor_list = cat(2,boundary_neighbor_list,circshift(boundary,-j)',boundary_neighbor_list,circshift(boundary,j)');        
    end
    
    boundary_neighbor_list = num2cell(boundary_neighbor_list,2);        
        
    % II Smoothing step by itself    
    for k = 1:nb_iterations
        
        % Mean on vertex neighbors
        smoothed_bound_vtx = cell2mat(cellfun(@(r) sum(V_out(r,:),1)/numel(r),boundary_neighbor_list,'un',0));
        
    end            
    
    V_out(boundary,:) = smoothed_bound_vtx; %  + raw_bound_normal_vect.*raw_bound_vtx_norm./smoothed_bound_vtx_norm;
    
    
end

fprintf('Mesh boundaries smoothed in %d seconds.\n',toc);


end % smooth_mesh_boundary_and_holes