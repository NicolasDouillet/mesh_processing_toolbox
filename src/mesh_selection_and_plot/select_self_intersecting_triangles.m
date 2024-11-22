function self_inter_tgl_id = select_self_intersecting_triangles(V, T)
%% select_self_intersecting_triangles : function to display self intersecting
% triangles on the mesh (T).
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
% - self_inter_tgl_id : positive integer row vector double, the index vector of self intersecting triangles.


%% Body
nb_tgl = size(T,1);
C = combnk(1:nb_tgl,2); % every possible triangle pair indices
self_inter_tgl_id = [];

for i = 1:size(C,1)
   
    self_inter_tgl_id = collect_intersecting_triangle_indices(V,T,C(i,1),C(i,2),self_inter_tgl_id);            
    
end

self_inter_tgl_id = unique(self_inter_tgl_id);
plot_mesh(V,T(setdiff(1:size(T,1),self_inter_tgl_id),:)), alpha(0.5);
shading faceted;
trisurf(T(self_inter_tgl_id,:),V(:,1),V(:,2),V(:,3),'FaceColor',[1 0 0]), hold on;


end % remove_self_intersecting_triangles