function bound_lengths = boundary_and_holes_perimeters(V, boundary)
%% boundary_and_holes_perimeters : function to compute perimeters
% of holes and boundary of the mesh in length unit.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
% - boundary : cell array of positive integer row vectors, size(boundary) = [nb_holes,1].
%
%
%%% Output argument
%
% - bound_lengths : positive real row vector double, the lengths of boundary and holes in length unit.
%                   Since boundary is sorted in descending order, bound_lengths is sorted the same way.                


%% Body
tic;
bound_lengths = cellfun(@(r) sum(sqrt(sum((V(r,:)-V(circshift(r,1,2),:)).^2,2))),boundary);
fprintf('%d perimeters computed in %d seconds.\n',size(boundary,1),toc);


end % boundary_and_holes_perimeters