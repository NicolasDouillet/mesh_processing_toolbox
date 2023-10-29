function isin = isinsideset(V, T, P)
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
assert(nargin < 4,'Too many input arguments.');
assert(isequal(size(V,2),size(P,2),3),'All the inputs must have the same number of colums (two dimensions here).');

% Body
epsilon = 1e3*eps;
nb_test_vtx = size(P,1);
nb_faces = size(T,1);
G = mean(V,1);

% Faces isobarycentres
Gi = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(T,2),'un',0));

% Vertex normals
vtx_idx = (1:size(V,1))';
face_idx_list = cellfun(@(i) find(sum(ismember(T,i),2))',num2cell(vtx_idx,2),'un',0);

vtx_ngb_face_normals = cellfun(@(c) compute_face_normals(V,T(c,:),'norm'),face_idx_list,'un',0);                   
ni = cell2mat(cellfun(@(c1) mean(c1,1),vtx_ngb_face_normals,'un',0));     
ni = ni./sqrt(sum(ni.^2,2));
   
orientation = sign(dot(ni,V-G,1));

% Face normals
mi = cross(V(T(:,2),:)-V(T(:,1),:),V(T(:,3),:)-V(T(:,1),:),2);
mi = mi./sqrt(sum(mi.^2,2));

if ~isequal(orientation,ones(nb_faces,1))
    
    mi = mi.*orientation;    
    
end

isin = zeros(nb_test_vtx,1); % out by default


for k = 1:nb_test_vtx
        
    % Gather four closest face indices
    D0 = sqrt(sum((Gi-P(k,:)).^2,2));    
    [~,nrst_face_idx] = sort(D0);
    clst_face_idx = nrst_face_idx(1:4);        
	
    % Exceptés les triangles auxquels le point appartient ?
    
    
% 	% Compute Hi projection of Pk on 4 closest faces
%     [~,H1] = point_to_plane_distance(P(k,:),mi(nrst_face_idx(1),:),V(T(nrst_face_idx(1),1),:));
%     [~,H2] = point_to_plane_distance(P(k,:),mi(nrst_face_idx(2),:),V(T(nrst_face_idx(2),1),:));
%     [~,H3] = point_to_plane_distance(P(k,:),mi(nrst_face_idx(3),:),V(T(nrst_face_idx(3),1),:));
%     [~,H4] = point_to_plane_distance(P(k,:),mi(nrst_face_idx(4),:),V(T(nrst_face_idx(4),1),:));
    
       
    % Compute dot product sign with face normal vectors and conclude
    isin(k) = dot(mi(clst_face_idx(1),:),P(k,:)-Gi(clst_face_idx(1),:),2) < -epsilon && ...
              dot(mi(clst_face_idx(2),:),P(k,:)-Gi(clst_face_idx(2),:),2) < -epsilon && ...
              dot(mi(clst_face_idx(3),:),P(k,:)-Gi(clst_face_idx(3),:),2) < -epsilon && ...
              dot(mi(clst_face_idx(4),:),P(k,:)-Gi(clst_face_idx(4),:),2) < -epsilon;


%     isin(k) = dot(mi(clst_face_idx(1),:),P(k,:)-H1,2) < -epsilon && ...
%               dot(mi(clst_face_idx(2),:),P(k,:)-H2,2) < -epsilon && ...
%               dot(mi(clst_face_idx(3),:),P(k,:)-H3,2) < -epsilon && ...
%               dot(mi(clst_face_idx(4),:),P(k,:)-H4,2) < -epsilon;
    


end
    
    
end % isinsideset


% point_to_plane_distance subfunction
function [d2H, H] = point_to_plane_distance(M, n, I)
%
% Author and support nicolas.douillet (at) free.fr, 2020-2023.


nb_pts = size(M,1);
d_I = -(n(1)*I(1)+n(2)*I(2)+n(3)*I(3));
t_H = -(repmat(d_I,[nb_pts,1])+n(1)*M(:,1)+n(2)*M(:,2)+n(3)*M(:,3)) / sum(n.^2);

x_H = M(:,1) + t_H*n(1);
y_H = M(:,2) + t_H*n(2);
z_H = M(:,3) + t_H*n(3);

% Orthogonal projected point
H = cat(2,x_H,y_H,z_H);
d2H = sqrt(sum((M-H).^2,2));


end % point_to_plane_distance