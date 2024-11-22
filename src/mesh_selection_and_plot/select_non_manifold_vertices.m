function nmnfld_vtx_id = select_non_manifold_vertices(V, T, option_display)
%% select_non_manifold_vertices : function to display non manifold vertices on the mesh (T).
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
% - option_display : logical *true/false | *1/0, enable/disable the diplay.
%
%
%%% Output argument
%
% - nmnfld_vtx_id : positive integer row vector, the index list of non manifold vertices.


%% Body
if nargin < 3
    
    option_display = true;
    
end

vtx_id = (1:size(V,1))';
edg_lists = find_edges_from_vertex_list(T,vtx_id);
vtx_ngb_edg_nb = cellfun(@(c) size(c,1),edg_lists);
tgl_id_list = find_triangle_sets_from_vertex_list(T,vtx_id);
vtx_ngb_tgl_nb = cellfun(@(c) numel(c),tgl_id_list);
nmnfld_vtx_id = find(vtx_ngb_edg_nb > vtx_ngb_tgl_nb+1);

if option_display
    
    plot_mesh(V,T);
    plot3(V(nmnfld_vtx_id,1),V(nmnfld_vtx_id,2),V(nmnfld_vtx_id,3),'ro','MarkerSize',8,'MarkerFaceColor',[1 0 0]), hold on;
    
end


end % select_non_manifold_vertices