function [N] = compute_vertex_normals(V, T, ngb_degre, mode)
%% compute_vertex_normals : function to compute vertex normals.
%
% Author & support : nicolas.douillet (at) free.fr, 2020.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [|  |  | ]
%
% - ngb_degre : positive integer scalar double in the range |[1; 6]|, the neighbor degre. Default value is 1.
%
% - mode : character string in the set : {'raw','norm'*,'RAW','NORM'}, the variable deciding
%          wether to normalize or not the vertex normals. Case insensitive.
%          
%
% Output argument
%
%       [ |  |  |]
% - N : [Nx Ny Nz], real matrix double, the vertex normalized normal vectors, size(N) = [nb_vertices,3].
%       [ |  |  |]


%% Body
% tic;

if nargin < 4
   
    mode = 'norm';
    
    if nargin < 3
       
        ngb_degre = 1;
        
    end
    
end

vtx_idx = (1:size(V,1))';
tgl_idx_list = find_triangle_sets_from_vertex_list(T,vtx_idx);

if ngb_degre > 1
    
    for n = 1:ngb_degre-1
        
        % New ngb triangle unique union list with the current tgl_idx_list
        tgl_idx_list = cellfun(@(c) unique(union(c,cell2mat(find_neighbor_triangle_indices(T,c))')),tgl_idx_list,'UniformOutput',false);                
        
    end
    
    vtx_ngb_face_normals = cellfun(@(c) compute_face_normals(V,T(c,:),'norm'),tgl_idx_list,'UniformOutput',false);
    N = cell2mat(cellfun(@(c) mean(c,1),vtx_ngb_face_normals,'UniformOutput',false));
    
else % if ngb_degre < 2        
                                                       
    vtx_ngb_face_normals = cellfun(@(c) compute_face_normals(V,T(c,:),'norm'),tgl_idx_list,'UniformOutput',false);                   
    N = cell2mat(cellfun(@(c1) mean(c1,1),vtx_ngb_face_normals,'UniformOutput',false));                                                           
    
end                

if strcmpi(mode,'norm')
    
    N = N./sqrt(sum(N.^2,2));    

end

% fprintf('%d normalized vertex normals computed in %d seconds.\n',size(V,1),toc);


end % compute_vertex_normals