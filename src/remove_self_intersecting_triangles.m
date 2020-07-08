function [T_out] = remove_self_intersecting_triangles(V, T_in)
%% remove_self_intersecting_triangles : function to remove
% self intersection triangles from the mesh.
%
% Author & support : nicolas.douillet (at) free.fr, 2020.
%
% Hypothesis : edge intersections, as well as T-vertices, counts as intersections.
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
%
% Output argument
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
tic;

nb_tgl = size(T_in,1);
C = combnk(1:nb_tgl,2); % every possible triangle pair indices
self_inter_tgl_idx = [];
T_out = T_in;

for i = 1:size(C,1)
   
    self_inter_tgl_idx = collect_intersecting_triangle_indices(V,T_in,C(i,1),C(i,2),self_inter_tgl_idx);     
    
end

self_inter_tgl_idx = unique(self_inter_tgl_idx);
T_out(self_inter_tgl_idx,:) = [];
fprintf('%d self intersecting triangles removed in %d seconds.\n',size(T_in,1)-size(T_out,1),toc);


end % remove_self_intersecting_triangles