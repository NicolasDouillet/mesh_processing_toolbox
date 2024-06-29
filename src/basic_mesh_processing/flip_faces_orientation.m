function T_out = flip_faces_orientation(T_in)
%% flip_faces_orientation : function to flip the
% orientation of each triangle of the mesh.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
% Input argument
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
%
% Output argument
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix, the output triangulation, size(T_out) = [nb_output_triangles,3],
%           [  |      |      |   ]
%
%           with nb_output_triangles = nb_input_triangles, and i1_out = i3_in, and i3_out = i1_in, i2_out = i2_in.


%% Body
% tic;
T_out = fliplr(T_in);
% fprintf('%d faces orientations flipped in %d seconds\n',size(T_in,1),toc);


end % flip_faces_orientation