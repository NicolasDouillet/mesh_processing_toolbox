function isin = isinsideset(V, T, P, epsilon)
% isinsideset : function to compute if a point belong to the inside of a
% given closed watertight 2D-manifold triangulated surface / set.
%
% Author and support nicolas (dot) douillet (at) free (dot) fr, 2023.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%       [|  |  | ]
% - P = [Px Py Pz], real matrix double, the point set to test, size(P) = [nb_test_vertices,3].
%       [|  |  | ]
%
%
% Output arguments
%
% - isin : logical vector, the reulting boolean vector.


% Input parsing
assert(nargin > 2,'Not enought input arguments.');
assert(nargin < 5,'Too many input arguments.');
assert(isequal(size(V,2),size(P,2),3),'All the inputs must have the same number of colums (two dimensions here).');

if nargin < 4
    epsilon = 1e3*eps;
end


% Body
nb_test_vtx = size(P,1);
nb_faces = size(T,1);
G = mean(V,1);

% Faces isobarycentres
Gi = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(T,2),'un',0));

% Face normals
mi = cross(V(T(:,2),:)-V(T(:,1),:),V(T(:,3),:)-V(T(:,1),:),2);
mi = mi./sqrt(sum(mi.^2,2));

orientation = sign(dot(mi,Gi-G,1));

if ~isequal(orientation,ones(nb_faces,1))
    mi = mi.*orientation;
end

isin = zeros(nb_test_vtx,1); % out by default


for k = 1:nb_test_vtx
    
    % Gather four closest face indices; shapes a tetrahedron
    D0 = sqrt(sum((Gi-P(k,:)).^2,2));
    [~,nrst_face_idx] = sort(D0);
    clst_face_idx = nrst_face_idx(1:4);
    
    % Compute dot product sign with face normal vectors and conclude
    isin(k) = dot(mi(clst_face_idx(1),:),P(k,:)-Gi(clst_face_idx(1),:),2) < -epsilon && ...
              dot(mi(clst_face_idx(2),:),P(k,:)-Gi(clst_face_idx(2),:),2) < -epsilon && ...
              dot(mi(clst_face_idx(3),:),P(k,:)-Gi(clst_face_idx(3),:),2) < -epsilon && ...
              dot(mi(clst_face_idx(4),:),P(k,:)-Gi(clst_face_idx(4),:),2) < -epsilon;
    
end
    
    
end % isinsideset