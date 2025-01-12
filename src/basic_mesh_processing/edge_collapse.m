function [V_out, T_out] = edge_collapse(V_in, T_in, edg_list)
%% edge_collapse : function to collapse edge(s) of edg_list.
% Triangle set (T) needs to be 2D-manifold for edge_collapse
% to work and edge couple must be valid existing edges.
% Working principle : each edge to collapse is replaced by its middle
% point.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2021-2025.
%
%
%%% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3]. Mandatory.
%          [ |    |    |  ]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3]. Mandatory.
%          [  |     |     |  ]
%
%              [ | | ]
% - edg_list = [v1 v2], positive integer matrix double, the edge set to collapse, size(edg_list) = [nb_edges,2]. Mandatory.
%              [ | | ] 
%
%
%%% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
edg_list = unique(sort(edg_list,2),'rows');
edg_cat_list = unique(reshape(edg_list.',1,[]));

V_out = V_in;
T_out = T_in;

while ~isempty(edg_list)
    
    v1 = edg_list(1,1);
    v2 = edg_list(1,2);
    
    % Find and suppress the triangle couple the edge belong to
    f = sum(ismember(T_out,edg_list(1,:)),2) == 2;
    T_out(f,:) = [];
    
    % Create the middle vertex
    mid_vtx = mean(V_out(edg_list(1,:),:),1);        
    
    % Add th middle vertex
    V_out = cat(1,V_out,mid_vtx);
    
    % Find the neighbor triangles which have one vertex of these edges
    % and replace them by the middle vertex.
    T_out(T_out == v1 | T_out == v2) = size(V_out,1); % new vertex index
    
    % Update edg_list
    edg_list(1,:) = []; % remove edge from the list
    edg_list(edg_list == v1 | edg_list == v2) = size(V_out,1); % reindex with new vertex index        
    
end

% Remove every couple vertices of the edges
[V_out,T_out] = remove_vertices(edg_cat_list,V_out,T_out);


end % edge_collapse