function T = switch_neighbor_pair_triangles(T, tid1, tid2)
%% switch_neighbor_pair_triangles : function to swuitch neighbor pair
% triangles.
%
% Author : nicolas.douillet (at) free.fr, 2024.


% /_!_\ Mess up triangle normals orientation

%% Body
% Find common edge
cmn_edge = intersect(T(tid1,:),T(tid2,:));

% Create new triangles
new_tgl1 = cat(2,setdiff(T(tid1,:),cmn_edge),cmn_edge(1),setdiff(T(tid2,:),cmn_edge));
new_tgl2 = cat(2,setdiff(T(tid2,:),cmn_edge),cmn_edge(2),setdiff(T(tid1,:),cmn_edge));

% Update triangulation
T = add_triangles(new_tgl1,T);
T = add_triangles(new_tgl2,T);
T = remove_triangles(T,[tid1,tid2]);


end % switch_neighbor_pair_triangles