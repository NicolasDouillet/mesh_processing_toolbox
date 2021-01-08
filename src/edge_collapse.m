function [V_out, T_out] = edge_collapse(V_in, T_in, edg_list)
%% edge_collapse : function to collapse one ore more edge(s).
% Triangle set needs to be 2D-manifold for edge_collapse to work
% and edge couple must be valid existing edges.
%
% Author & support : nicolas.douillet (at) free.fr, 2021.
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
%              [ | | ]
% - edg_list = [e1 e2], positive integer matrix double, the edge set to collapse, size(edg_list) = [nb_edges,2].
%              [ | | ] 
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
% edg_list = unique(sort(edg_list,2),'rows'); % precondition

V_out = V_in;
T_out = T_in;

% Find and suppress the triangle couples the edges belong to 
tgl_idx_list = find_triangle_indices_from_edges_list(T_out,edg_list);
T_out(unique([tgl_idx_list{:}]),:) = [];
% T_out = remove_triangles([tgl_idx_list{:}],T_out);

% Create and add the middle vertices
mid_vtx = 0.5*(V_out(edg_list(:,1),:) + V_out(edg_list(:,2),:));
V_out = cat(1,V_out,mid_vtx);
new_vtx_idx = repelem(1+size(V_in,1):size(V_out,1),2);

% Find the neighbor triangles which have one vertex of these edges
% and replace them by the middle vertex.
edg_cat_list = reshape(edg_list.',1,[]);
M = containers.Map(edg_cat_list,new_vtx_idx);
f_vtx2sub = isKey(M,num2cell(T_out));
T_out(f_vtx2sub) = cell2mat(values(M,num2cell(T_out(f_vtx2sub))));

% Remove every couple vertices of the edges
[V_out,T_out] = remove_vertices(unique(edg_cat_list),V_out,T_out);

end % edge_collapse