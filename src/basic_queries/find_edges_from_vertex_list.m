function edg_lists = find_edges_from_vertex_list(T, vtx_id)
%% find_edges_from_vertex_list : function to compute the edges lists
% in the triangulation T which contain the vertex indices of vtx_id.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3]. Mandatory.
%       [ |  |  |]
%
% - vtx_id : positive integer row vector double, the vertex indices list, vtx_id = (1:size(V,1)). Mandatory.
%
%
%%% Output argument
%
% - edg_lists : positive integer matrix double, the edge lists,
%               size(edg_lists) =  [nb_edg,2], with nb_edg the number of edges.


%% Body
% tic;
edg_lists = cellfun(@(i) reshape(setdiff(T(any(T==i,2),:),i),[],1),num2cell(vtx_id),'un',0);
edg_lists = cellfun(@(c,i) cat(2,c,i*ones(numel(c),1)),edg_lists,num2cell(vtx_id),'un',0);
% fprintf('find_edges_from_vertex_list request executed in %d seconds.\n',toc);


end % find_edges_from_vertex_list