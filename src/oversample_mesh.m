function [V_out, T_out] = oversample_mesh(V_in, T_in, nb_it)
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
% - nb_it : positive integer scalar double, the number of iterations to perform.
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
V = V_in;
T = T_in;


for n = 1:nb_it
    
    nb_vtx = size(V,1);
    nb_tgl = size(T,1);
    
    V_new  = zeros(0,3);
    T_new  = zeros(0,3);
    
    for k = 1:nb_tgl
        
        E = combnk(T(k,:),2);
        
        V_new = cat(1,V_new,0.5*(V(E(:,2),:) + V(E(:,1),:))); % middle of each edge
        
        T_new = cat(1,T_new, [nb_vtx+3*k-2, nb_vtx+3*k, nb_vtx+3*k-1],...
                             [T(k,1), nb_vtx+3*k-2, nb_vtx+3*k-1],...
                             [T(k,2), nb_vtx+3*k,   nb_vtx+3*k-2],...
                             [T(k,3), nb_vtx+3*k-1, nb_vtx+3*k]);
                                          
    end
    
    V = cat(1,V,V_new);
    T = cat(1,T,T_new);
    
end

[V_out,T_out] = remove_duplicated_vertices(V,T);


end % oversample_mesh