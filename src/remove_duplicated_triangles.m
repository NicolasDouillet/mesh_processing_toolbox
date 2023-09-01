function T_out = remove_duplicated_triangles(T_in)
%% remove_duplicated_triangles : function to remove duplicated
% triangles present in the triangulation T_in.
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2023.
%
%
% Input argument
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
%
% Output argument
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3],
%           [  |      |      |   ]
%
%           where nb_output_triangles = nb_input_triangles - nb_duplicata.


%% Body
% tic;
T_sort = sort(T_in,2);
[~,idx,~] = unique(T_sort,'rows','stable'); % sort a copy only to keep face orientation
T_out = T_in(idx,:);
% fprintf('%d duplicated triangles removed in %d seconds.\n',size(T_in,1)-size(T_out,1),toc);


end % remove_duplicated_triangles