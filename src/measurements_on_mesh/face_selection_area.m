function area = face_selection_area(V, T_set)
%% face_selection_area : function to compute the area of the faces selection T_set.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025
%
%
%%% Input arguments
%        
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
%           [|  |  | ]
% - T_set = [i1 i2 i3], positive integer matrix double, the triangle selection, size(T_set) = [nb_triangles,3]. Mandatory.
%           [|  |  | ]           
%
%
%%% Output argument
%
% - area : positive real scalar double, the area of the face selection, in area unit.


%% Body
tic;

tgl_area = cellfun(@(r1,r2,r3) sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                   num2cell(V(T_set(:,2),:)-V(T_set(:,1),:),2),num2cell(V(T_set(:,3),:),2),...
                   num2cell(V(T_set(:,1),:),2),'un',0);

area = 0.5*sum([tgl_area{:}]);

fprintf('Face selection area computed in %d seconds.\n',toc);


end % face_selection_area