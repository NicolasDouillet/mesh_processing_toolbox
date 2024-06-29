function [V_out, T_out] = vertex_decimation(V_in, T_in, vtx_idx2suppr)
%% vertex_decimation : function to decimate vertices.
% Working principle : in the triangulation the vertex
% to decimate is replaced by its nearest neighbor.
%
% Author : nicolas.douillet (at) free.fr, 2021-2024.
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
% - vtx_idx2suppr, positive integer matrix double, the vertex set indices to decimate, size(vtx_idx2suppr) = [1,nb_vertex]. 
%
%
% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           where nb_output_vertices = nb_input_vertices - nb_vtx2suppr.
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
vtx_idx2suppr = unique(vtx_idx2suppr);
vtx_idx_cpy = vtx_idx2suppr;

V_out = V_in;
T_out = T_in;

while ~isempty(vtx_idx2suppr)
    
    vtx_idx = vtx_idx2suppr(1);
    vtx_ngb_idx = find_one_vertex_neighbor_indices(T_out,vtx_idx);
    
    % Find one unique nearest vertex index       
    dst_vect = sqrt(sum((V_out(vtx_ngb_idx,:)-repmat(V_out(vtx_idx,:),[numel(vtx_ngb_idx),1])).^2,2));
    nrst_vtx_idx = vtx_ngb_idx(1,find(dst_vect == min(dst_vect),1));
    
    % Find and suppress the triangle couple the edge belong to
    f = sum(ismember(T_out,[vtx_idx,nrst_vtx_idx]),2) == 2;
    T_out(f,:) = [];        
    
    % Find the neighbor triangles which have this vertex
    % and replace it by the nearest vertex.
    T_out(T_out == vtx_idx) = nrst_vtx_idx;    
    
    % Update vertex list 
    vtx_idx2suppr(1) = []; % remove current vertex index              
    
end

% Remove vertices
[V_out,T_out] = remove_vertices(vtx_idx_cpy,V_out,T_out);


end % vertex_decimation