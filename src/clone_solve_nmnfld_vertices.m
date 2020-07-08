function [V_out, T_out] = clone_solve_nmnfld_vertices(V_in, T_in, nmnfld_vtx_idx)
%% clone_solve_nmnfld_vertices : function to virtually solve
% non manifold vertex issues by cloning them.
%
% Author and support : nicolas.douillet (at) free.fr, 2020.
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
% - nmnfld_vtx_idx : positive integer row vector, the index list of non manifold vertices.
%
%
% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           where nb_output_vertices = nb_input_vertices - nb_duplicata.
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
tic;
V_out = V_in;
T_out = T_in;

% Loop on nmnfld_vtx_idx
for i = 1:numel(nmnfld_vtx_idx)
    
    % Query every belonging triangles
    tgl_idx_list = find_triangles_from_vertex_list(T_out,nmnfld_vtx_idx(i));
    T_set = T_out(tgl_idx_list,:);
    
    % Segment this triangles subset into components
    [~,tgl_patches] = segment_connected_components(T_set,'indices'); 
    
    % Reindex it according to the original whole triangle set
    tgl_patches = back_map_triangle_sets_indices(tgl_patches, tgl_idx_list);
    
    % Clone vertex and find indices to substitute
    clone_vtx = V_out(nmnfld_vtx_idx(i),:);
    nmnfld_vtx_abs_idx_in_T = find(T_out == nmnfld_vtx_idx(i));
    [r,c] = ind2sub(size(T_out),nmnfld_vtx_abs_idx_in_T);
    
    % For each patch from the 2nd to the last, replace the original vertex
    % by the clone
    for k = 1:numel(tgl_patches) % = nb cells
        
        tgl_patch_idx = cell2mat(tgl_patches(k,1));
        
        if ismember(nmnfld_vtx_idx(i),T_out(tgl_patch_idx,:))
            
            [V_out,clone_idx] = add_vertices(clone_vtx,V_out);
            T_out(r(ismember(r,tgl_patch_idx)),c(ismember(r,tgl_patch_idx))) = clone_idx;
            
        end
        
    end
    
end

% Remove original now unreferenced -non manifold- vertices
[V_out,T_out] = remove_vertices(nmnfld_vtx_idx,V_out,T_out,'indices');

fprintf('duplicate_nmnfld_vertices request executed in %d seconds. %d clone vertices added.\n',toc,size(V_out,1)-size(V_in,1));


end % clone_solve_nmnfld_vertices


%% Subfunction
function [out_tgl_patches] = back_map_triangle_sets_indices(in_tgl_patches, tgl_idx_list)


out_tgl_patches = in_tgl_patches;

for k = 1:size(out_tgl_patches,1) % nb cells
    
    idx_patch_in = cell2mat(in_tgl_patches(k,1));        
    idx_patch_out = tgl_idx_list(idx_patch_in);        
    out_tgl_patches(k,1) = {idx_patch_out};
    
end


end % back_map_triangle_sets_indices