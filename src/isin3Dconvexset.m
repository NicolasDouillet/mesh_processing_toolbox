function [isin] = isin3Dconvexset(V, H, M, epsilon)
% isin3Dconvexset : function to check if a vertex is located inside or outside a given
% convex set, boundary not included (opened set). Supports dimensions 2 and 3.
%
% Author & support : nicolas.douillet (at) free.fr, 2018-2020.
%
%
% Syntax
%
% isin = isin3Dconvexset(V, H, M);
%
%
% Description
%
% isin = isin3Dconvexset(V, H, M) computes the boolean isin which is true/logical 1
% in the case the vertex M belongs to the opened convex set (V,H) defined by
% the vertex set V, and its hyperplane set H. isin is false/logical 0 in the
% case vertex M belongs to the complementary set or the boundary convex hull.
%
%
% See also : CONVHULL
%
%
% Input arguments
%
%       [ |  |  |]
% - V = [Vx Vy Vz], real matrix double, the convex set, with size(V,1) > size(V,2) to define a relevant convex set.
%       [ |  |  |]
%
%       [ |  |]
% - H = [i1 i2], positive integer matrix double, the hyperplane set (edge list in 2D, face list in 3D). 
%       [ |  |]
%
%                H elements / rows don't need to be coherently oriented. Size(H) = [nb_hyperplanes,2].
%
%       [ |  |  |]
% - M = [Mx My Mz], real row vector or matrix double, the coordinates of the vertex / vertices  to check. Size(M,2) = size(V,2).
%       [ |  |  |]
%
% - epsilon : real scalar double : admitted floating point error, power of eps.
%
%
% Output argument
%
%          [      |      ]
% - isin = [logical 1 / 0], logical true (1)/false (0) scalar / column vector. The boolean result. Size(isin) = [size(M,1),1].
%          [      |      ]

% Body
nb_h = size(H,1);

% Hyperplane isobarycentres
Gh = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(H,2),'un',0));

% Face normals
n = cross(V(H(:,2),:)-V(H(:,1),:),V(H(:,3),:)-V(H(:,1),:));

% Vectors from hyperplane barycentres to candidate points
Gv = cellfun(@(r) repmat(r,[size(Gh,1),1]) - Gh,num2cell(M,2),'un',0);

% Signed dot product
sdot_prod = cellfun(@(c) sign(dot(c,n,2).*(abs(dot(c,n,2)) > epsilon)),Gv,'un',0);

% Compute isin logical value
isin = cell2mat(cellfun(@(c) isequal(c,ones(nb_h,1)) || ...
                             isequal(c,-ones(nb_h,1)),sdot_prod,'un',0));


end % isin3Dconvexset