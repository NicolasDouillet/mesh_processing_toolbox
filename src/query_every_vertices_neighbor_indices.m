function [neighbor_list] = query_every_vertices_neighbor_indices(T, ngb_degre, nb_vtx)
%% query_every_vertices_neighbor_indices : function to find the indices list
% of neighbor vertices of every vertices the triangulation T refers to.
%
% Author & support : nicolas.douillet (at) free.fr, 2020.
%
%
% Input arguments
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3].
%       [|  |  | ]
%
% - ngb_degre : positive integer scalar in the range |[1; 6]|, the neighbor degre. Default value is 1.
%
% - nb_vtx : positive integer, the number of vertices. Mandatory if more than one input argument.
%
%
% Output argument
%
% - neighbor_list : cell array of positive integer row vectors, the (indices) list of neighbor vertices,
%                   size(neighbor_list) = [nb_vertices,1].


%% Body
% tic;
assert(nargin > 1,'Not enough input arguments.');
assert(nargin < 4,'Too many input arguments.');
    
if nargin < 2
    
    ngb_degre = 1;
    
else 
        
    assert(isreal(ngb_degre) && ngb_degre > 0 && floor(ngb_degre) == ngb_degre,'ngb_degre must be a positive integer in the range |[1; 6]|.');
    
end

M = cell2mat(cellfun(@(c) nchoosek(c,2),num2cell(T,2),'un',0));
neighbor_list = accumarray([M(:,1);M(:,2)],[M(:,2);M(:,1)],[],@(x){unique(x)'});


if ngb_degre > 1
    
    vtx_idx = num2cell((1:nb_vtx)');
        
    for k = 2:ngb_degre
                
        kth_degre_neighbor_list = cellfun(@(c) neighbor_list(c),neighbor_list,'un',0);
        kth_degre_neighbor_list = cellfun(@(c) c(:),kth_degre_neighbor_list,'un',0);
        kth_degre_neighbor_list = cellfun(@(c) c(:)',kth_degre_neighbor_list,'un',0);
        neighbor_list = cellfun(@(c1,c2) setdiff(cell2mat(c1),c2),kth_degre_neighbor_list,vtx_idx,'un',0);               
        
    end
    
end

% fprintf('query_every_vertices_neighbor_indices request executed in %d seconds.\n',toc);


end % query_every_vertices_neighbor_indices