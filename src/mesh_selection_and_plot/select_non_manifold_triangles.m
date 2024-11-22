function nmnfld_tgl_id_list = select_non_manifold_triangles(V, T)
%% select_non_manifold_triangles : function to select and display
% non manifold triangles on the mesh (T).
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%
%%% Output argument
%
% - nmnfld_tgl_id_list : positive integer row vector, the index list of non manifold triangles. 


%% Body
edg_list = query_edges_list(T,'raw');
tgl_id_list = find_triangle_indices_from_edges_list(T,edg_list);
nmnfld_tgl_id_list = cellfun(@(r) r(numel(r) > 2,:),tgl_id_list,'un',0);
nmnfld_tgl_id_list = nmnfld_tgl_id_list(~cellfun('isempty',nmnfld_tgl_id_list));
nmnfld_tgl_id_list = unique([nmnfld_tgl_id_list{:}]);

plot_mesh(V,T);
trisurf(T(nmnfld_tgl_id_list,:),V(:,1),V(:,2),V(:,3),'FaceColor',[1 0 0]); hold on;


end % select_non_manifold_edges