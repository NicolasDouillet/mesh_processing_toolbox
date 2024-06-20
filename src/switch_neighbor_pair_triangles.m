function T = switch_neighbor_pair_triangles(T, tid1, tid2)
%% switch_neighbor_pair_triangles : function to switch neighbor pair triangles.
% Preserves face normals orientation.
%
% Author : nicolas.douillet (at) free.fr, 2024.
%
%
%% Body
tgl1 = T(tid1,:);
tgl2 = T(tid2,:);
edge2split = intersect(tgl1,tgl2);
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
T = add_triangles(new_tgl1,T);
T = add_triangles(new_tgl2,T);
T = remove_triangles(T,[tid1,tid2]);


end % switch_neighbor_pair_triangles