function min_dst = point_to_mesh_min_distance(P, V, T)
%% point_to_mesh_min_distance : function to compute
% the minimum distance between a given 3D point and the mesh.
% In case the point doesn't orthogonally project on a face/triangle,
% the minimum distance to the point set is taken.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%
% - P = [Px Py Pz], real vector double, the 3D point, size(P) = [1,3].
%        
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%
%%% Output argument
%
% - min_dst : positive real scalar double, the minimum distance between P and the mesh. In case no triangle is found
%             to orthogonally projet P on, the minimum distance is taken between P and the point set V.


%% Body
tic;

% Step I : Orthogonnaly project P on H for each triangle planes
[d2H,H] = cellfun(@(r) point_to_plane_distance(P,cross(V(r(1,2),:)-V(r(1,1),:),...
                  V(r(1,3),:)-V(r(1,1),:),2),V(r(1,1),:)),num2cell(T,2),'un',0);

% Step II : Keep only the H ones which are inside their triangles ; in case there
% are none, take the min distance to the point set
isin = cell2mat(cellfun(@(r1,r2) is_point_inside_triangle(V(r1,:),...
                r2),num2cell(T,2),H,'un',0));

dst_vect = [d2H{isin,:}];

% Step III : Keep the minimum only
min_dst = min(dst_vect);
min_dst_2_pt_set = min(sqrt(sum((repmat(P,[size(V,1),1])-V).^2,2)));


if ~isempty(min_dst)
    
    min_dst = min_dst(1,1);
    
    if min_dst > min_dst_2_pt_set
       
        min_dst = min_dst_2_pt_set;
        
    end

else
    
    fprintf('Can''t find any triangle to orthogonally projet the point on.\nTake the minimum distance to the point set.\n');
    min_dst = min_dst_2_pt_set;
    
end

fprintf('Point to mesh minimum distance computed in %d seconds.\n',toc);


end % point_to_mesh_min_distance


%% is_point_inside_triangle subfunction
function isin = is_point_inside_triangle(C, P)


comb = num2cell([1 2; 2 3; 3 1],2); % for triangles only
V = C - repmat(P,[size(C,1),1]);

outward_centre_angles = cellfun(@(r) atan2d(sqrt(sum(cross(V(r(1,1),:),V(r(1,2),:),2).^2,2)),dot(V(r(1,1),:),V(r(1,2),:),2)),comb);
angle_sum = sum(outward_centre_angles);

isin = round(angle_sum) == 360;


end % is_point_inside_triangle