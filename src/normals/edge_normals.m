function N_e = edge_normals(T, N, E, mode)
%% Fonction to compute the normals to the edges of the mesh.
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
%       [ |  |  |]
% - N : [Nx Ny Nz], real matrix double, the face normal vectors, size(N) = [nb_triangles,3].
%       [ |  |  |]
%
%       [ | | ]
%       [i1 i2]
% - E = [i2 i3], positive integer matrix double, the edge list, size(edg_list) = [nb_edges,2].
%       [i3 i1]
%       [ | | ]
%
% - mode : character string in the set : {'raw','norm'*,'RAW','NORM'}, the variable deciding
%          wether to normalize or not the vertex normals. Case insensitive. Optional.
%
%
%%% Output argument
%
%         [  |    |    | ]
% - N_e : [N_ex N_ey N_ez], real matrix double, the edge normal vectors, size(N_e) = [nb_edges,3].
%         [  |    |    | ]


%% Body
if nargin < 4
   
    mode = 'norm';
    
end

tgl_id_list = cell2mat(find_triangle_indices_from_edg_list(T,E));
N_e = 0.5*(N(tgl_id_list(:,1),:) + N(tgl_id_list(:,2),:));

if strcmpi(mode,'norm')
    
    N_e = N_e./sqrt(sum(N_e.^2,2));
            
end


end % edge_normals