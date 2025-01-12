function [V_dual, T_dual] = dual_of_trimesh(V, T)
%% dual_of_trimesh : function to compute the dual mesh of a given triangular mesh.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2023-2025.
%
%
% Hypothesis : input mesh is a 2D manifold triangulation
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the input point set, size(V) = [nb_input_vertices,3]. Mandatory.
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the input triangulation, size(T) = [nb_input_triangles,3]. Mandatory.
%       [ |  |  |]
%
%
%%% Output arguments
%
%            [  |      |      |   ]
% - V_dual = [X_dual Y_dual Z_dual], real matrix double, the output point set, size(V_dual) = [nb_output_vertices,3],
%            [  |      |      |   ]
%
%           where nb_output_vertices = nb_input_vertices - nb_duplicata.
%
%            [   |       |       |   ]
% - T_dual = [i1_dual i2_dual i3_dual], positive integer matrix double, the output triangulation, size(T_dual) = [nb_output_triangles,3].
%            [   |       |       |   ]


%% Body
V_dual = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(T,2),'un',0));
T_dual = cell(size(V,1),1);

% Loop on every vertices of the set
for vtx_id = 1:size(V,1)

    % Find triangles linked to each vertex
    tgl_ngb_id = find_triangles_from_vertex_list(T,vtx_id);
    
    % Sort triangle indices around common linked vertex
    new_polyhedron = order_vtx_ngb_tgl(T,tgl_ngb_id);        
    T_dual(vtx_id,1) = num2cell(new_polyhedron,2);            

end


end % dual_of_trimesh


%% sorted_ngb_tgl_id subfunction
function sorted_ngb_tgl_id = order_vtx_ngb_tgl(T, ngb_tgl_id)


sorted_ngb_tgl_id = ngb_tgl_id(1);
k = 1;
tgl_id = sorted_ngb_tgl_id(k);

while numel(sorted_ngb_tgl_id) < numel(ngb_tgl_id)
    
    ngb_tgl = cell2mat(find_neighbor_triangle_indices(T,tgl_id));
    ngb_tgl = intersect(ngb_tgl_id,ngb_tgl); % only the triangles linked to the same center vertex
    
    if numel(sorted_ngb_tgl_id) > 1
        
        nxt_tgl_id = setdiff(ngb_tgl,sorted_ngb_tgl_id(end-1)); % the first which is not already in the list
        
    else
        
        nxt_tgl_id = ngb_tgl(1);
        
    end
    
    sorted_ngb_tgl_id = cat(2,sorted_ngb_tgl_id,nxt_tgl_id(1));
    
    k = k + 1;
    tgl_id = sorted_ngb_tgl_id(k);
    
end


end % order_vtx_ngb_tgl