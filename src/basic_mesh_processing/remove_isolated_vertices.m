function [V_out, T_out] = remove_isolated_vertices(V_in, T_in)
%% remove_isolated_vertices : function to remove isolated vertices
% (missing in the triangulation T_in) from the vertex set (V_in).
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2023-2025.
%
%
%%% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3]. Mandatory.
%          [ |    |    |  ]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3]. Mandatory.
%          |  |     |     |  ]
%
%
%%% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           with nb_output_vertices = nb_input_vertices - nb_isolated_vertices.
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
isl_vtx_id = setdiff(1:size(V_in,1),unique(T_in(:)));
[V_out,T_out] = remove_vertices(isl_vtx_id,V_in,T_in);


end % remove_isolated_vertices