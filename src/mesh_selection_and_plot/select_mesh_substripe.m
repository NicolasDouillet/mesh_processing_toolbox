function [V_out, T_out] = select_mesh_substripe(V_in, T_in, n, axis_thres, one_sided_bound_val)
%% select_mesh_substripe : function to select a mesh sub stripe.
%
% Author : nicolas.douillet (at) free.fr, 2024.
%
%
% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3].
%          [ |    |    |  ]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
% - n = [nx ny nz], real row vector double, one plane normal vector, size(n) = [1,3].
%
% - axis_thres : real row vector double, the axis threshold. size(axis_thres) = [1,3].
%
% - one_sided_bound_val : integer scalar double, the one side bound value.
%
%
% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
I = n.*axis_thres;
[~,H_in] = point_to_plane_distance(V_in,n,I);
dst = vecnorm((V_in-H_in)',2)';
f = find(dst < one_sided_bound_val);
V_out = V_in(f,:);
M = containers.Map(f,(1:size(f,1))');
g = find(ismember(T_in,f));
[i,~] = ind2sub([size(T_in,1),size(T_in,2)],g);
T1 = T_in(i,:);
T2 = T1(:);
T3 = ismember(T2,f);
T3 = reshape(T3,[size(T1,1),size(T1,2)]);
T4 = T1(ismember(T3,[1 1 1],'rows'),:);
[H,W] = size(T4);
T5 = T4(:);
T5 = num2cell(T5(:));
T_out = values(M,T5);
T_out = reshape(cell2mat(T_out),[H,W]);


end % select_mesh_substripe