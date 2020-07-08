function [area] = compute_face_selection_area(V, T_set)
%% compute_face_selection_area : function to compute
% the area of a face selection.
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
%           [|  |  | ]
% - T_set = [i1 i2 i3], positive integer matrix double, the triangle selection, size(T_set) = [nb_triangles,3], 
%           [|  |  | ]           
%
%
% Output argument
%
% - area : real scalar double, the area of the face selection, in area unit.


%% Body
tic;

tgl_area = cellfun(@(r1,r2,r3) sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                   num2cell(V(T_set(:,2),:)-V(T_set(:,1),:),2),num2cell(V(T_set(:,3),:),2),...
                   num2cell(V(T_set(:,1),:),2),'UniformOutput',false);
               
area = 0.5*sum([tgl_area{:}]);

fprintf('Face selection area computed in %d seconds.\n',toc);


end % compute_face_selection_area