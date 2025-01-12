function N = vertex_normals(V, T, ngb_degre, mode)
% %vertex_normals : function to compute vertex normals (N).
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3]. Mandatory.
%       [|  |  | ]
%
% - ngb_degre : positive integer scalar double in the range |[1; 6]|, the neighbor degre. Default value is 1. Optional.
%
% - mode : character string in the set : {'raw','norm'*,'RAW','NORM'}, the variable deciding
%          wether to normalize or not the vertex normals. Case insensitive. Optional.
%          
%
%%% Output argument
%
%       [ |  |  |]
% - N : [Nx Ny Nz], real matrix double, the vertex normalized normal vectors, size(N) = [nb_vertices,3].
%       [ |  |  |]


%% Input parsing
if nargin < 4
   
    mode = 'norm';
    
    if nargin < 3
       
        ngb_degre = 1;
        
    end
    
end


%% Body
% tic;
vtx_id = (1:size(V,1))';
tgl_id_list = find_triangle_sets_from_vertex_list(T,vtx_id);

if ngb_degre > 1
    
    for n = 1:ngb_degre-1
        
        % New ngb triangle unique union list with the current tgl_id_list
        tgl_id_list = cellfun(@(c) unique(union(c,cell2mat(find_neighbor_triangle_indices(T,c))')),tgl_id_list,'un',0);                
        
    end
    
    vtx_ngb_face_normals = cellfun(@(c) face_normals(V,T(c,:),'norm'),tgl_id_list,'un',0);
    N = cell2mat(cellfun(@(c) mean(c,1),vtx_ngb_face_normals,'un',0));
    
else % if ngb_degre < 2        
                                                       
    vtx_ngb_face_normals = cellfun(@(c) face_normals(V,T(c,:),'norm'),tgl_id_list,'un',0);                   
    N = cell2mat(cellfun(@(c1) mean(c1,1),vtx_ngb_face_normals,'un',0));                                                           
    
end                

if strcmpi(mode,'norm')
    
    N = N./sqrt(sum(N.^2,2));    

end

% fprintf('%d normalized vertex normals computed in %d seconds.\n',size(V,1),toc);


end % vertex_normals