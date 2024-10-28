function [V_out, T_out] = clone_solve_non_manifold_vertices(V_in, T_in, nmnfld_vtx_id)
%% clone_solve_non_manifold_vertices : function to virtually solve
% non manifold vertex issues by cloning them. May create flat triangles.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
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
% - nmnfld_vtx_id : positive integer row vector, the index list of non manifold vertices.
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

% Loop on nmnfld_vtx_id
for i = 1:numel(nmnfld_vtx_id)
    
    % Query every belonging triangles
    tgl_id_list = find_triangles_from_vertex_list(T_out,nmnfld_vtx_id(i));
    T_set = T_out(tgl_id_list,:);
    
    % Segment this triangles subset into components
    [~,tgl_patches] = segment_connected_components(T_set,'index'); 
    
    % Reindex it according to the original whole triangle set
    tgl_patches = back_map_triangle_sets_indices(tgl_patches, tgl_id_list);
    
    % Clone vertex and find indices to substitute
    clone_vtx = V_out(nmnfld_vtx_id(i),:);
    nmnfld_vtx_abs_id_in_T = find(T_out == nmnfld_vtx_id(i));
    [r,c] = ind2sub(size(T_out),nmnfld_vtx_abs_id_in_T);
    
    % For each patch from the 2nd to the last, replace the original vertex
    % by the clone
    for k = 1:numel(tgl_patches) % = nb cells
        
        tgl_patch_id = cell2mat(tgl_patches(k,1));
        
        if ismember(nmnfld_vtx_id(i),T_out(tgl_patch_id,:))
            
            % [V_out,clone_id] = add_vertices(clone_vtx,V_out);
            V_out = cat(1,V_out,clone_vtx);
            T_out(r(ismember(r,tgl_patch_id)),c(ismember(r,tgl_patch_id))) = size(V_out,1)-size(clone_vtx,1)+1:size(V_out,1);
            
        end
        
    end
    
end

% Remove original now unreferenced -non manifold- vertices
[V_out,T_out] = remove_vertices(nmnfld_vtx_id,V_out,T_out,'index');

fprintf('duplicate_nmnfld_vertices request executed in %d seconds. %d clone vertices added.\n',toc,size(V_out,1)-size(V_in,1));


end % clone_solve_non_manifold_vertices


%% back_map_triangle_sets_indices subfunction
function out_tgl_patches = back_map_triangle_sets_indices(in_tgl_patches, tgl_id_list)


out_tgl_patches = in_tgl_patches;

for k = 1:size(out_tgl_patches,1) % nb cells
    
    idx_patch_in = cell2mat(in_tgl_patches(k,1));        
    idx_patch_out = tgl_id_list(idx_patch_in);        
    out_tgl_patches(k,1) = {idx_patch_out};
    
end


end % back_map_triangle_sets_indices