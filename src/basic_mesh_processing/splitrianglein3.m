function T_out = splitrianglein3(T_in, tid, vid)
%% splitrianglein3 : function to split one given triangle in three new
% triangles given the triangle id, tid, the new vertex id, vid, in the point
% set, the input triangulation (T_in). The triangle is removed after the split.
%
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2024-2025.
%
%
%%% Input arguments
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3]. Mandatory.
%          [  |     |     |  ]
%
% - tid : positive integer scalar, the id of the triangle to split. Mandatory.
%
% - vid : positive integer scalar, the new vertex id. Mandatory.
%
%
%%% Output argument
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Create new triangles
new_tgl1 = cat(2,T_in(tid,1:2),vid);
new_tgl2 = cat(2,T_in(tid,2:3),vid);
new_tgl3 = cat(2,T_in(tid,3),T_in(tid,1),vid);

%% Update triangulation
T_set = cat(1,new_tgl1,new_tgl2,new_tgl3);
T_out = add_triangles(T_set,T_in);
T_out = remove_triangles(T_out,tid);


end % splitrianglein3