function isconvex = issetconvex(V)
%% Function to determine if a given set of points V is convex or not.
% The set is convex if each and every of its elements belong to the
% convex hull. This means the set and its convex hull are
% actually coincident. This also implies the set has no internal point
% and is fully included and defined by its outer boundary / convex hull.
% Note : four or more Coplanar points in the set should be avoided since
% the convex hull algorithm doesn't always include them.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2024-2025.

%%% Input argument
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
%%% Output argument
%
% - isconvex : logical true/false | 1/0, the convexness.


%% Body
precision = 1e4*eps;
V = uniquetol(V,precision,'ByRows',true);
T = convhull(V);
vtx_list = unique(T(:));
isconvex = isequal(vtx_list,(1:size(V,1))');


end % issetconvex