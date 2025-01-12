function tgl_id_list = find_triangles_from_vertex_list(T, vtx_id)
%% find_triangles_from_vertex_list : function to compute the index
% list of triangles containing the vertex indices of vtx_id.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3]. Mandatory.
%       [|  |  | ]
%
% - vtx_id : positive integer row vector double, the vertex indices list. Mandatory.
%
%
%%% Output argument
%
% - tgl_id_list : positive integer row vector double, the triangle indices list.


%% Body
% tic;
tgl_id_list = find(sum(reshape(ismember(T(:),vtx_id),size(T)),2));
% fprintf('find_triangles_from_vertex_list request executed in %d seconds.\n',toc);


end % find_triangles_from_vertex_list