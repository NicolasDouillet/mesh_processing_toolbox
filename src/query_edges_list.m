function [edg_list] = query_edges_list(T, mode)
%% query_edges_list : function to query the edges list
% corresponding to the triangulation T.
%
% Author & support : nicolas.douillet (at) free.fr, 2020.
%
%
% Input arguments
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [|  |  | ]
%
% - mode : character string in the set {'sorted','raw','SORTED','RAW'}, the
%          variable deciding wether to sort or not the edges in ascending
%          order. Case insensitive.
%
%
% Output argument
%
%              [ | | ]
%              [i1 i2]
% - edg_list = [i2 i3], positive integer matrix double, the edges list, size(edg_list) =  [nb_edg,2]
%              [i3 i1]
%              [ | | ]
%
%              with nb_edg the number of edges.


%% Body
% tic;
L = cat(2,T,T(:,1)); % loop
R = repelem(L,1,[1 2 2 1]); % replicated

edg_list = cell2mat(cellfun(@(x) reshape(x,[2,3])',num2cell(R,2),'UniformOutput',false));

if nargin  > 1 && strcmpi(mode,'sorted')
    
    edg_list = sort(edg_list,2);
    
elseif nargin  < 2 || strcmpi(mode,'raw')
    
    % do nothing
    
else
    
    % do nothing
    
end

% fprintf('query_edges_list request executed in %d seconds.\n',toc);


end % query_edges_list