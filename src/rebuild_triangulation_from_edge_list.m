function [T] = rebuild_triangulation_from_edge_list(E)
%% rebuild_triangulation_from_edge_list : function to rebuild the
% triangulation T from the edge list E. 
%
% Working principle : process by edges triplet.
% Is actually the reciprocal function of query_edges_list.
%
% Author & support : nicolas.douillet (at) free.fr, 2020.
%
%
% Input argument
%
%       [ | | ]
%       [i1 i2]
% - E = [i2 i3], positive integer matrix double, the oriented edge list, size(E) = [nb_edges,2].
%       [i3 i1]
%       [ | | ]
%                                                [ 3*n ]
%       assumed to be sorted by triplets of rows [3*n+1], where each edge triplet provide one triangle.
%                                                [3*n+2]
%
% Output argument
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the rebuilt triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]


%% Body
% tic;
C = mat2cell(E,repelem(3,floor(size(E,1)/3)),2);
R_list = cellfun(@(t) reshape(t',[1,6]),C,'UniformOutput',false); % replicated
U = cellfun(@(i) unique(i,'stable'),R_list,'UniformOutput',false); % unique
T = cell2mat(U);
% fprintf('%d triangles mesh rebuilt from %d edges in %d seconds.\n',size(T,1),size(E,1),toc);


end % rebuild_triangulation_from_edge_list