function [V_out, T_out] = oversample_mesh(V_in, T_in)
%% oversample_mesh : function to oversample a mesh.
%
% Author & support : nicolas.douillet (at) free.fr, 2023.
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
%
% Keep faces orientation


%% Body
V_out = V_in;
T_out = zeros(0,3);

nb_vtx = size(V_in,1);
nb_tgl = size(T_in,1);

V_new  = zeros(0,3);
T_new  = zeros(0,3);

for k = 1:nb_tgl
    
    E = combnk(T_in(k,:),2);
    
    V_new = cat(1,V_new,0.5*(V_in(E(:,2),:) + V_in(E(:,1),:))); % middle of each edge
    
    T_new = cat(1,T_new, [nb_vtx+3*k-2, nb_vtx+3*k, nb_vtx+3*k-1],...
                         [T_in(k,1), nb_vtx+3*k-2, nb_vtx+3*k-1],...
                         [T_in(k,2), nb_vtx+3*k,   nb_vtx+3*k-2],...
                         [T_in(k,3), nb_vtx+3*k-1, nb_vtx+3*k]);
    
end

V_out = cat(1,V_out,V_new);
T_out = cat(1,T_out,T_new); % do not use add_triangles since no risk of duplicata here
[V_out,T_out] = remove_duplicated_vertices(V_out,T_out);


end % oversample_mesh