function self_inter_tgl_idx_out = collect_intersecting_triangle_indices(V, T, i1, i2, self_inter_tgl_idx_in)
%% collect_intersecting_triangle_indices : function to collect intersecting triangle indices.
% 
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
% Hypothesis : edges, except vertices, belong to the boundary.
%
% Warninng : not yet appropriated for large meshes. Too much CPU time
% consuming.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the input point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the input triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
% - i1 : positive integer scalar double, index of the first triangle.
%
% - i2 : positive integer scalar double, index of the second triangle.
%
% - self_inter_tgl_idx_in : positive integer row vector double, input list
%                           of self intersecting triangle indices.
%
%
% Output arguments
%
% - self_inter_tgl_idx_out : positive integer row vector double, output list
%                            of self intersecting triangle indices. If
%                            triangles of indices i1 and i2 intersect, then
%                            self_inter_tgl_idx_out = cat(2,self_inter_tgl_idx_in,[i1,i2]).


%% Body
self_inter_tgl_idx_out = self_inter_tgl_idx_in;

T1 = T(i1,:);
T2 = T(i2,:);

% Triangle edge sets
E1 = query_edges_list(T1,'raw');
E2 = query_edges_list(T2,'raw');

% Triangles normal vector
n1 = cross(V(T1(1,2),:)-V(T1(1,1),:),V(T1(1,3),:)-V(T1(1,1),:));
n2 = cross(V(T2(1,2),:)-V(T2(1,1),:),V(T2(1,3),:)-V(T2(1,1),:));

for k = 1:size(E1,1)
    
    u1 = diff(V(E1(k,:),:),1,1);
    N1 = V(E1(k,1),:);
    [I1,rc1] = line_plane_intersection(u1,N1,n2,V(T2(1,1),:),false);
    
    % Convex set corresponding to T2
    C2 = V(T2,:);
    
    if ~isempty(I1) && ~ismember(I1,C2,'rows')
        
        isin1 = is_point_inside_triangle(C2,I1);
        
        if (rc1 == 1 || rc1 == 2) && isin1 % there exists at least one intersection point in T2
            
            self_inter_tgl_idx_out = cat(2,self_inter_tgl_idx_out,[i1,i2]);
            disp('Pair triangle intersection detected.');
            break;
            
        end
        
    end
    
end


for k = 1:size(E2,1)
    
    u2 = diff(V(E2(k,:),:),1,1);
    N2 = V(E2(k,1),:);
    [I2,rc2] = line_plane_intersection(u2,N2,n1,V(T1(1,1),:),false);
    
    % Convex set corresponding to T1
    C1 = V(T1,:);
    
    if ~isempty(I2) && ~ismember(I2,C1,'rows')
        
        isin2 = is_point_inside_triangle(C1,I2);
        
        if (rc2 == 1 || rc2 == 2) && isin2 % there exists at least one intersection point in T1
            
            self_inter_tgl_idx_out = cat(2,self_inter_tgl_idx_out,[i1,i2]);
            disp('Pair triangle intersection detected.');
            break;
            
        end
        
    end
    
end


end % collect_intersecting_triangle_indices


%% is_point_inside_triangle subfunction
function isin = is_point_inside_triangle(C, P)


comb = num2cell([1 2; 2 3; 3 1],2); % for triangles only
V = C - repmat(P,[size(C,1),1]);

outward_centre_angles = cellfun(@(r) atan2d(sqrt(sum(cross(V(r(1,1),:),V(r(1,2),:),2).^2,2)),...
                                     dot(V(r(1,1),:),V(r(1,2),:),2)),comb); 
                                 
angle_sum = sum(outward_centre_angles);
isin = round(angle_sum) == 360;


end % is_point_inside_triangle