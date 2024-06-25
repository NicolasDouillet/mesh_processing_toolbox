function T_out = flip_edge(T_in, edge2split)
%% flip_edge : function to flip a given edge.
% Preserves face normals orientation.
%
% Author : nicolas.douillet (at) free.fr, 2024.
%
%
% Input arguments
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
% - edge2split = [e1 e2], positive integer matrix double, the edge to split, size(edge2split) = [1,2].
%
%
% Output arguments
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
T_out = T_in;
tgl_idx_list = cell2mat(find_triangle_indices_from_edges_list(T_in,edge2split));
size(tgl_idx_list)


if ~isempty(tgl_idx_list) && numel(tgl_idx_list) > 1
    
    tglidx1 = tgl_idx_list(1);    
    tglidx2 = tgl_idx_list(2);
    tgl1 = T_in(tglidx1,:);    
    tgl2 = T_in(tglidx2,:);
    
    % if ~isempty(edge2split) && numel(edge2split) == 2
    
    edgpos1 = bitor(tgl1 == edge2split(1,1),tgl1 == edge2split(1,2));
    edgpos2 = bitor(tgl2 == edge2split(1,1),tgl2 == edge2split(1,2));
    
    if isequal(edgpos1,logical([1 0 1]))
        
        orientedg1 = fliplr(tgl1(edgpos1));
        
    else
        
        orientedg1 = tgl1(edgpos1);
        
    end
    
    op_vtx1 = tgl1(~edgpos1); % opposite vertex #1
    
    
    if isequal(edgpos2,logical([1 0 1]))
        
        orientedg2 = fliplr(tgl2(edgpos2));
        
    else
        
        orientedg2 = tgl2(edgpos2);
        
    end
    
    op_vtx2 = tgl2(~edgpos2); % opposite vertex #2
    
    
    % Create new triangles
    new_tgl1 = cat(2,op_vtx1,orientedg1(1,1),op_vtx2);
    new_tgl2 = cat(2,op_vtx2,orientedg2(1,1),op_vtx1);
    
    % Add new triangles
    T_out = add_triangles(new_tgl1,T_out);
    T_out = add_triangles(new_tgl2,T_out);
    T_out = remove_triangles(T_out,[tglidx1,tglidx2]);
    
else % if isempty(tgl_idx_list) || numel(tgl_idx_list) < 2
    
    warning(['Edge [',num2str(edge2split),'] is not shared between two triangles and won''t be flipped.']);
    
end


end % flip_edge