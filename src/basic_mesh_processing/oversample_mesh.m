function [V_out, T_out] = oversample_mesh(V_in, T_in, mode, tgl_idx)
%% oversample_mesh : function to oversample a mesh.
%
% Author : nicolas.douillet (at) free.fr, 2023-2024.
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
% - tgl_idx : row vector double of positive integers, the index vector of the triangles to oversample.
%
% - mode : charachter string in the set {'default','DEFAULT','midedge','MIDEDGE','centre','CENTRE'}, the oversampling mode.
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
% Preserves face normals orientation


nb_tgl = size(T_in,1);

%% Input parsing
if nargin < 4
    
    tgl_idx = 1:nb_tgl;
    
    if nargin < 3
        
        mode = 'midedge';
        
    end
    
end


%% Body
nb_vtx = size(V_in,1);

V_new  = zeros(0,3);
T_new  = zeros(0,3);

if strcmpi(mode,'midedge') || strcmpi(mode,'default')
    
    for k = tgl_idx
        
        E = combnk(T_in(k,:),2);
        
        V_new = cat(1,V_new,0.5*(V_in(E(:,2),:) + V_in(E(:,1),:))); % middle of each edge
        
        T_new = cat(1,T_new, [nb_vtx+3*k-2, nb_vtx+3*k, nb_vtx+3*k-1],...
                             [T_in(k,1), nb_vtx+3*k-2, nb_vtx+3*k-1],...
                             [T_in(k,2), nb_vtx+3*k,   nb_vtx+3*k-2],...
                             [T_in(k,3), nb_vtx+3*k-1, nb_vtx+3*k]);
        
    end
    
else % if strcmpi(mode,'centre')
    
    
    for k = tgl_idx
        
        V_new = cat(1,V_new,mean(V_in(T_in(k,:),:),1)); % isobarycentre of each triangle
        
        T_new = cat(1,T_new,[T_in(k,1) T_in(k,2) nb_vtx+k],...
                            [T_in(k,2) T_in(k,3) nb_vtx+k],...
                            [T_in(k,3) T_in(k,1) nb_vtx+k]);
        
    end
    
end

V_out = cat(1,V_in,V_new);
T_new = cat(1,T_new,T_in(setdiff(1:size(T_in,1),tgl_idx),:));
T_out = T_new;

tol = 1e3*eps;
[V_out,T_out] = remove_duplicated_vertices(V_out,T_out,tol);


end % oversample_mesh