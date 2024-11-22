function [V_out, T_out] = select_submesh(V_in, T_in, n, I)
%% select_submesh : function to extract a subselection from the initial mesh (T).
%
% General principle of the algorithm : extract vertices and associated triangles
% of the mesh which are located on one side / half space of the plan defined by (n, I).
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%  
%%% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3].
%          [ |    |    |  ]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%                                                                        
% - n : real row vector double, a cutting plan normal vector, size(n) = [1,3].
%  
% - I : real row vector double, a point belonging to the cutting plan, size(I) = [1,3].
%      
%
%%% Output arguments                                                       
%                 
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3].
%           [  |     |     |  ]
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]                                       


%% Body
tic;

% I Project vertices on the plan
[~,H_in] = point_to_plane_distance(V_in,n,I);

% II Compute signed distances
sgn = dot((V_in-H_in),repmat(n,[size(V_in,1),1]),2);
f = find(sgn > 0);

% III Select points
V_out = V_in(f,:);

% IV Create (keys,values) map = (vertices_filtered_indices,vertices_raw_indices)
M = containers.Map(f,(1:size(f,1))');

% V Extract associated triangles
g = find(ismember(T_in,f));
[i,~] = ind2sub([size(T_in,1),size(T_in,2)],g);
T1 = T_in(i,:);

% VI 2nd filtering step : suppress triangles which one of the vertices is
% on the other side of the plan
T2 = T1(:);
T3 = ismember(T2,f);
T3 = reshape(T3,[size(T1,1),size(T1,2)]);
T4 = T1(ismember(T3,[1 1 1],'rows'),:);

[H,W] = size(T4);
T5 = T4(:);
T5 = num2cell(T5(:));

% VII Reindex triangles set
T_out = values(M,T5);
T_out = reshape(cell2mat(T_out),[H,W]);

fprintf('submesh with %d vertices and %d triangles selected in %d seconds.\n',size(V_out,1),size(T_out,1),toc);


end % select_submesh