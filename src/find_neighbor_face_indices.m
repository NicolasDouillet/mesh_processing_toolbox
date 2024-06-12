function ngb_T = find_neighbor_face_indices(F, F_subset)
%% find_neighbor_face_indices : function to compute the list of faces
% which are neighbors (share one edge) to the faces in F_subset.
%
% Author : nicolas.douillet (at) free.fr, 2023-2024.
%
%
% Input arguments
%
%       [ |  |  |]
% - F = [i1 i2 i3], positive integer matrix double, the triangulation, size(F) = [nb_faces,3].
%       [ |  |  |]
%
% - F_subset : either positive integer row vector double* (the indices of the faces; default behaviour) or
%              positive integer matrix double giving the explicit indices triplet list. In this latter case,
%              mode must be set to 'explicit'.
%
%
% Output argument
%
% - ngb_F : positive integer matrix double, the neighbor face indices, size(ngb_F) = [nbg_nb,3],
%           with nbg_nb the number of neighbors.


%% Body
% tic;               
ngb_T = cellfun(@(f) find(sum(ismember(F,f),2)==2),num2cell(F_subset,2),'un',0);      
% fprintf('find_neighbor_face_indices request executed in %d seconds.\n',toc);


end % find_neighbor_face_indices