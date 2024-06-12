function [V_out, T_out] = split_edge(V_in, T_in, edge2split)
%% split_edge : function to split one ore more edges of the mesh into two edges.
% Process and take one edge at a time in input.
% Preserves normals orientation.
% For 2D manifold meshes only.
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
%                [|   |]      
% - edge2split = [e1 e2], positive integer matrix double, the set of the edges to split. size(edge2split) = [1, 2].
%                [|   |]
%
%
% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           where nb_output_vertices = nb_input_vertices + 1.
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]
%
%           with nb_output_triangles = nb_input_triangles + 2.


%% Body
V_out = V_in;
T_out = T_in;

% Create and add new vertex
new_vtx_coord = 0.5 * (V_out(edge2split(1,1),:) + V_out(edge2split(1,2),:));
[V_out,new_vtx_id] = add_vertices(new_vtx_coord,V_out);

% Find triangles and edge opposite vertices
tgl_idx_list = cell2mat(find_triangle_indices_from_edges_list(T_in,edge2split(1,:)));

% Retrieve originally oriented edge in triangles
orientedg = zeros(numel(tgl_idx_list),2);
op_vtx    = zeros(1,numel(tgl_idx_list)); % opposite vertex

for t = 1:numel(tgl_idx_list)
    
    tgl = T_out(tgl_idx_list(t),:);
    edgpos = bitor(tgl == edge2split(1,1),tgl == edge2split(1,2));
    
    if isequal(edgpos,logical([1 0 1]))
        
        orientedg(t,:) = fliplr(tgl(edgpos));
        
    else
        
        orientedg(t,:) = tgl(edgpos);
        
    end
    
    op_vtx(1,t) = tgl(~edgpos);
    
end

for p = 1:numel(op_vtx)
    
    % Create new triangles
    new_tgl_set1 = cat(2,orientedg(p,1),new_vtx_id,op_vtx(p));
    new_tgl_set2 = cat(2,new_vtx_id,orientedg(p,2),op_vtx(p));
    
    % Add new triangles
    T_out = add_triangles(new_tgl_set1,T_out);
    T_out = add_triangles(new_tgl_set2,T_out);
    
end

% Remove old splited triangles
T_out  = remove_triangles(T_out,tgl_idx_list,'indices');


end % split_edge