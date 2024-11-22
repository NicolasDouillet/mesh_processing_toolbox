function T = splitrianglein3(T, tid, vid)
%% splitrianglein3 : function to split one given triangle (tid) in three new
% triangles given the triangle id, the new vertex (vid) id in the point set, the
% triangulation (T), and the total number of vertices in the set including the
% new one. The triangle is deleted after the split.
%
%
%%% Author : nicolas.douillet (at) free.fr, 2024.


%% Create new triangles
new_tgl1 = cat(2,T(tid,1:2),vid);
new_tgl2 = cat(2,T(tid,2:3),vid);
new_tgl3 = cat(2,T(tid,3),T(tid,1),vid);

%% Update triangulation
T_set = cat(1,new_tgl1,new_tgl2,new_tgl3);
T = add_triangles(T_set,T);
T = remove_triangles(T,tid);


end % splitrianglein3