function neighbor_list = find_every_vertices_neighbor_indices(T, ngb_degre, nb_vtx)
%% find_every_vertices_neighbor_indices : function to find the indices list
% of neighbor vertices of every vertices the triangulation T refers to.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix, the triangulation, size(T) = [nb_triangles,3]. Mandatory.
%       [|  |  | ]
%
% - ngb_degre : positive integer scalar in the range |[1; 6]|, the neighbor degre. Default value is 1. Optional.
%
% - nb_vtx : positive integer, the number of vertices. Mandatory if more than one input argument.
%
%
%%% Output argument
%
% - neighbor_list : cell array of positive integer row vectors, the (indices) list of neighbor vertices,
%                   size(neighbor_list) = [nb_vertices,1].


% tic;

%% Input parsing    
if nargin < 2
    
    ngb_degre = 1;
    
else 
        
    if ~isreal(ngb_degre) || ngb_degre < 0 || floor(ngb_degre) ~= ngb_degre
        
        error('ngb_degre must be a positive integer in the range |[1; 6]|.');               
        
    end
    
end


%% Body
M = cell2mat(cellfun(@(c) nchoosek(c,2),num2cell(T,2),'un',0));
neighbor_list = accumarray([M(:,1);M(:,2)],[M(:,2);M(:,1)],[],@(x){unique(x)'});


if ngb_degre > 1
    
    vtx_id = num2cell((1:nb_vtx)');
        
    for k = 2:ngb_degre
                
        kth_degre_neighbor_list = cellfun(@(c) neighbor_list(c),neighbor_list,'un',0);
        kth_degre_neighbor_list = cellfun(@(c) c(:),kth_degre_neighbor_list,'un',0);
        kth_degre_neighbor_list = cellfun(@(c) c(:)',kth_degre_neighbor_list,'un',0);
        neighbor_list = cellfun(@(c1,c2) setdiff(cell2mat(c1),c2),kth_degre_neighbor_list,vtx_id,'un',0);               
        
    end
    
end

% fprintf('find_every_vertices_neighbor_indices request executed in %d seconds.\n',toc);


end % find_every_vertices_neighbor_indices