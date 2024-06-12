function T = build_triangulation_from_edge_list(E, mode)
%% build_triangulation_from_edge_list : function to build the
% triangulation T from the edge list E. 
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
% Input argument
%
%       [ | | ]
%       [i1 i2]
% - E = [i2 i3], positive integer matrix double, the oriented edge list, size(E) = [nb_edges,2].
%       [i3 i1]
%       [ | | ]
%
% - mode : character string in the set {'sorted','raw'}, case insensitive.
%
%
% Output argument
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the rebuilt triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]


%% Body
% tic;
if nargin > 1 && strcmpi(mode,'sorted')
    
    C = mat2cell(E,repelem(3,floor(size(E,1)/3)),2);
    R_list = cellfun(@(t) reshape(t',[1,6]),C,'un',0); % replicated
    U = cellfun(@(i) unique(i,'stable'),R_list,'un',0); % unique
    T = cell2mat(U);
    
elseif nargin < 2 || strcmpi(mode,'raw')
    
    E = unique(sort(E,2),'rows');
    vtx_idx_list = sort(unique(E(:)'));
    T = zeros(0,3);
    
    for i = vtx_idx_list
        
        % Find every edges linked to each vertex
        i_lk_vtx = get_vertex_linked_vertices(E,i);
        
        for j = i_lk_vtx
            
            j_lk_vtx = get_vertex_linked_vertices(E,j);
            third_vtx = intersect(i_lk_vtx,j_lk_vtx);
            
            if ~isempty(third_vtx)
                
                % No need to sort new triangles here since add_triangle already check for duplicata
                new_tgl_set = cat(2,repmat([i,j],[numel(third_vtx),1]),third_vtx');
                T = add_triangles(new_tgl_set,T);
                
            end
            
        end
        
    end
    
end

% fprintf('%d triangles mesh rebuilt from %d edges in %d seconds.\n',size(T,1),size(E,1),toc);


end % build_triangulation_from_edge_list


%% get_vertex_linked_vertices subfunction
function vtx_idx_list = get_vertex_linked_vertices(E, vtx_idx)
%
% Author : nicolas.douillet (at) free.fr, 2023-2024.


vtx_idx_list = setdiff(E(any(E==vtx_idx,2),:),vtx_idx)';


end % get_vertex_linked_vertices