function T = build_triangulation_from_edge_list(E, mode)
%% build_triangulation_from_edge_list : function to build the triangulation T from the edge list E. 
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input argument
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
%%% Output argument
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the rebuilt triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]


%% Body
% tic;
if nargin > 1 && strcmpi(mode,'sorted')
        
    C = mat2cell(E,repelem(3,floor(size(E,1)/3)),2);
    R_list = cellfun(@(t) reshape(t',[1,6]),C,'un',0); % with potential replicated edges
    U = cellfun(@(i) unique(i,'stable'),R_list,'un',0); % with unique edges only
    T = cell2mat(U);
    
elseif nargin < 2 || strcmpi(mode,'raw')
    
    E = unique(sort(E,2),'rows');
    vtx_id_list = sort(unique(E(:)'));
	T = zeros(floor(floor(size(E,1)/3)),3); % maximum number of triangles        
    
    n = 1;
    
    for i = vtx_id_list
        
        % Find every edges linked to each vertex
        i_lk_vtx = find_one_vertex_neighbor_indices(E,i);
        
        for j = i_lk_vtx
                        
            j_lk_vtx = find_one_vertex_neighbor_indices(E,j);
            
            % Find every third vertex connected to this edge
            third_vtx = intersect(i_lk_vtx,j_lk_vtx); 
            
            new_tgl_set = cat(2,repmat([i,j],[numel(third_vtx),1]),third_vtx');
            T(n:n+size(new_tgl_set,1)-1,:) = new_tgl_set;            
            n = n + size(new_tgl_set,1);
            
        end
        
    end
	   
    T(~any(T,2),:) = [];
	T = remove_duplicated_triangles(T);            
        
end

% fprintf('%d triangles mesh rebuilt from %d edges in %d seconds.\n',size(T,1),size(E,1),toc);


end % build_triangulation_from_edge_list