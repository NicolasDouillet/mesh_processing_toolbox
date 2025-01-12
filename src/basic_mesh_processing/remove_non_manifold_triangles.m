function T_out = remove_non_manifold_triangles(T_in)
%% remove_non_manifold_triangles : function to remove
% non manifold triangles from the mesh (T_in).
% Working principle & criterion : non manifold triangles are the
% ones detected such that one of their edges at least is shared by
% at least two other triangles.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input argument
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3]. Mandatory.
%          [  |     |     |  ]
%
%
%%% Output argument
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3],
%           [  |      |      |   ]
%
%           with nb_output_triangles = nb_input_triangles - nb_non_manifold triangles.


%% Body
tic;
T_out = T_in;
edg_list = query_edg_list(T_in,'raw');
tgl_id_list = find_triangle_indices_from_edg_list(T_in,edg_list);
nmnfld_tgl_id_list = cellfun(@(r) r(numel(r) > 2,:),tgl_id_list,'un',0);
nmnfld_tgl_id_list = nmnfld_tgl_id_list(~cellfun('isempty',nmnfld_tgl_id_list));
nmnfld_tgl_id_list = unique([nmnfld_tgl_id_list{:}]);
T_out(nmnfld_tgl_id_list,:) = [];
fprintf('%d non manifold triangle(s) removed in %d seconds.\n',size(T_in,1)-size(T_out,1),toc);


end % remove_non_manifold_triangles