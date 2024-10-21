function isconvex = issetconvex(V)
% Function to determine if a given set of points V is convex or not.
% The set is convex if each and every of its elements belong to the
% convex hull. This means the set and its convex hull are
% actually coincident. This also implies the set has no internal point
% and is fully included and defined by its outer boundary / convex hull.
%
% Author : nicolas.douillet (at) free.fr, 2024.


T = convhull(V);
vtx_list = unique(T(:));
isconvex = isequal(vtx_list,(1:size(V,1))');


end % issetconvex