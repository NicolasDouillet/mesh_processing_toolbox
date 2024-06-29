function [V_out, T_out] = remove_flat_triangles(V_in, T_in)
%% remove_flat_triangles : function to find then suppress
% triangles containing twice or more the same vertex.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
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
%
% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3].
%           [  |     |     |  ]
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]
%
%           where nb_output_triangles = nb_input_triangles - nb_flat_triangles.


%% Body
tic;
tol = 1e3*eps;
[V_out,T_out] = remove_duplicated_vertices(V_in,T_in,tol);
C = num2cell(T_out,2);
F = cell2mat(cellfun(@(r) numel(unique(r)) < 3,C,'un',0));
T_out = T_out(~F,:);
fprintf('%d flat triangle(s) removed in %d seconds.\n',size(T_in,1)-size(T_out,1),toc);


end % remove_flat_triangles