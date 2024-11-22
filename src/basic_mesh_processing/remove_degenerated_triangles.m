function T_out = remove_degenerated_triangles(V_in, T_in)
%% remove_degenerated_triangles : function to find then suppress
% triangles containing aligned vertices.
%
%%% Author : nicolas.douillet (at) free.fr, 2023-2024.
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
%
%%% Output arguments
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]
%
%           where nb_output_triangles = nb_input_triangles - nb_degenerated_triangles.


%% Body
tic;
C = num2cell(T_in,2);
F = cell2mat(cellfun(@(r) abs(mod(atan2(norm(cross(V_in(r(2),:)-V_in(r(1),:),V_in(r(3),:)-V_in(r(1),:))),...
                                               dot(V_in(r(2),:)-V_in(r(1),:),V_in(r(3),:)-V_in(r(1),:))),pi)) < 1e3*eps,C,'un',0));
                                           
T_out = T_in(~F,:);
fprintf('%d degenerated triangle(s) removed in %d seconds.\n',size(T_in,1)-size(T_out,1),toc);


end % remove_degenerated_triangles