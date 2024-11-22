function [V_out, T_out] = upsample_mesh(V_in, T_in, mode, tgl_id)
%% upsample_mesh : function to upsample a gieven mesh (T_in).
% Preserves face normals orientation.
%
%%% Authors : nicolas.douillet (at) free.fr, 2023-2024.
%             Stepan Kortus (cpu time optimization)
%
%
%%% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3].
%          [ |    |    |  ]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
% - tgl_id : row vector double of positive integers, the index vector of the triangles to upsample.
%
% - mode : charachter string in the set {'default','DEFAULT','midedge','MIDEDGE','centre','CENTRE'}, the upsampling mode.
%
%
%%% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3].
%           [  |     |     |  ]
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


nb_tgl = size(T_in,1);

%% Input parsing
if nargin < 4
    
    tgl_id = 1:nb_tgl;
    
    if nargin < 3
        
        mode = 'midedge';
        
    end
    
end


%% Body
nb_vtx = size(V_in,1);
i = 1;
j = 1;

if strcmpi(mode,'midedge') || strcmpi(mode,'default')

    % create pre-allocated array
    V_new = nan(nb_tgl*3,3);
    T_new = nan(nb_tgl*4,3);
    
    for k = tgl_id
        
        E = combnk(T_in(k,:),2);        
        tempV = 0.5*(V_in(E(:,2),:) + V_in(E(:,1),:)); % middle of each edge
        V_new(i:i+2,:) = tempV;
        i = i+3;

        tempT = [nb_vtx+3*k-2, nb_vtx+3*k,   nb_vtx+3*k-1;...
                 T_in(k,1),    nb_vtx+3*k-2, nb_vtx+3*k-1;...
                 T_in(k,2),    nb_vtx+3*k,   nb_vtx+3*k-2;...
                 T_in(k,3),    nb_vtx+3*k-1, nb_vtx+3*k;];
       
        T_new(j:j+3,:) = tempT;
        j = j+4;       
        
    end

    
else % if strcmpi(mode,'centre')

    % create pre-allocated array
    V_new = nan(nb_tgl,3);
    T_new = nan(nb_tgl*3,3);    
    
    for k = tgl_id                

        tempV = mean(V_in(T_in(k,:),:),1);

        V_new(i,:) = tempV;
        i = i+1;
        
        tempT = [T_in(k,1) T_in(k,2) nb_vtx+k;...
                 T_in(k,2) T_in(k,3) nb_vtx+k;...
                 T_in(k,3) T_in(k,1) nb_vtx+k];

        T_new(j:j+2,:) = tempT;
        j = j+3;       
        
    end
    
end


V_out = cat(1,V_in,V_new);
T_new = cat(1,T_new,T_in(setdiff(1:size(T_in,1),tgl_id),:));
T_out = T_new;

tol = 1e3*eps;
[V_out,T_out] = remove_duplicated_vertices(V_out,T_out,tol);


end % upsample_mesh