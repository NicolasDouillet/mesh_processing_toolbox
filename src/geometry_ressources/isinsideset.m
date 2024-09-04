function [isin, V, T] = isinsideset(V, T, P, N, epsilon)
%% isinsideset : function to compute if a point belong to the inside of a
% one component given closed watertight 2D-manifold triangulated surface / set.
% Boundary is excluded.
%
% Author : nicolas.douillet (at) free.fr, 2023-2024.
%
% TODO : + option boundary included / excluded*
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
%       [|  |  | ]
% - N = [Nx Ny Nz], real matrix double, the face normals, size(N) = [nb_triangles,3].
%       [|  |  | ]
%
% - epsilon : scalar double, the tolerance on the error.
%
%
% Output argument
%
% - isin : logical vector, the resulting boolean vector.


%% Input parsing
assert(nargin > 2,'Not enought input arguments.');
assert(nargin < 6,'Too many input arguments.');
assert(isequal(size(V,2),size(P,2),3),'All the inputs must have the same number of colums.');


% Mesh upsampling preprocessing step
min_edglength = min_edge_length(V,T);
max_edglength = max_edge_length(V,T);

if (max_edglength/min_edglength > 2 && max_edglength/min_edglength <= 8)
    
    while max_edglength > 2*min_edglength              
        
        [V,T] = upsample_mesh(V,T);
        max_edglength = max_edge_length(V,T);
        
    end
    
    
elseif (max_edglength/min_edglength) > 8
    
    % Find every triangles whom one edge is greater than the threshold
    E = query_edges_list(T);
    E = unique(sort(E,2),'rows');
    
    while max_edglength > 2*min_edglength
        
            edglength = sqrt(sum((V(E(:,2),:)-V(E(:,1),:)).^2,2));
            edgidx2split = find(edglength > 2*min_edglength);
        
            for p = 1:numel(edgidx2split)
        
                [V,T] = split_edge(V,T,E(edgidx2split(p),:));
        
            end
                
        max_edglength = max_edge_length(V,T);
        E = query_edges_list(T);
        E = unique(sort(E,2),'rows');
        
    end
        
    T = reorient_all_faces_coherently(V,T);
        
end


%% Body
Gi = zeros(size(T));

% Compute face isobarycentres
for  i = 1:size(T,1)
    Gi(i,:) = mean(V(T(i,:),:),1);
end


if nargin < 5
    
    epsilon = eps;
    
    if nargin < 4
        
        % Compute face normals
        N = cross(V(T(:,2),:)-V(T(:,1),:),V(T(:,3),:)-V(T(:,1),:),2);
        N = N./sqrt(sum(N.^2,2));
                
        G = mean(V,1);
        orientation = sign(dot(N,Gi-G,1));
        
        if ~isequal(orientation,ones(size(T,1),1))
            
            N = N.*orientation;
            
        end
        
    end
    
end


isin = false(size(P,1),1); % out by default

for k = 1:size(P,1)
    
    % Query closest and furthest faces
    D = sqrt(sum((Gi-P(k,:)).^2,2));
    [~,nrst_face_id] = min(D);
    [~,frst_face_id] = max(D);
    
    % Compute dot product sign with face normal vectors and conclude
    isin(k) = dot(N(nrst_face_id,:),P(k,:)-Gi(nrst_face_id,:),2) < -epsilon && ... % whereas positive when outside
              dot(N(frst_face_id,:),P(k,:)-Gi(frst_face_id,:),2) < -epsilon; 
                 
end

    
end % isinsideset