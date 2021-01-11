function [V_out, T_out] = triangle_collapse(V_in, T_in, tgl_idx_list)
%% triangle_collapse : function to collapse one ore more triangle(s).
% Triangle set needs to be 2D-manifold for triangle_collapse to work
% and triangle indices must be correspond to valid existing triangles.
% Working principle : each triangle to collapse is replaced by its
% isobarycentre, which is equivalent to consecutively collapse
% two edges of this triangle.
%
% Author & support : nicolas.douillet (at) free.fr, 2021.
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
% - tgl_idx_list, positive integer matrix double, the triangle set indices to collapse, size(tgl_idx_list) = [1,nb_triangles]. 
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
edg_list = query_edges_list(T_in(tgl_idx_list,:));

% 2 out of 3 edges are actually sufficient
edg_idx = 1:size(edg_list,1);
edg_idx2suppr = mod(edg_idx,3) == 0;
edg_list(edg_idx2suppr,:) = [];

[V_out,T_out] = edge_collapse(V_in,T_in,edg_list);


end % triangle_collapse