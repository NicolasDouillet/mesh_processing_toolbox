function [bound_lengths] = compute_holes_and_boundary_perimeters(V, boundary)
%% compute_holes_and_boundary_perimeters : function to compute perimeters
% of holes and boundary of the mesh in length unit.
%
% Author & support : nicolas.douillet (at) free.fr, 2020.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
% - boundary : cell array of positive integer row vectors, size(boundary) = [nb_holes,1].
%
%
% Output argument
%
% - bound_lengths : positive real row vector, the lengths of boundary and holes in length unit.
%                   Since boundary is sorted in descending order, bound_lengths is sorted the same way.                


%% Body
tic;
bound_lengths = cellfun(@(r) sum(sqrt(sum((V(r,:)-V(circshift(r,1,2),:)).^2,2)),1),boundary);
fprintf('%d perimeters computed in %d seconds.\n',size(boundary,1),toc);


end % compute_holes_and_boundary_perimeters