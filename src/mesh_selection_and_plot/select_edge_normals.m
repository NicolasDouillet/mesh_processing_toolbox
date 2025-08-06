function N_e = select_edge_normals(V, T, N, E, mode, option_display)
%% select_edge_normals : function to display the edge normals on the mesh.
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
% - option_display : logical *true/false | *1/0, enable/disable the diplay. Optional.
%
%
%%% Output argument
%
%         [  |    |    | ]
% - N_e : [N_ex N_ey N_ez], real matrix double, the edge normal vectors, size(N_e) = [nb_edges,3].
%         [  |    |    | ]


%% Body
if nargin < 6
    
    option_display = true;
    
    if nargin < 5
        
        mode = 'norm';
        
    end
    
end

N_e = edge_normals(T,N,E,mode);
I = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(E,2),'un',0));

if option_display
    
    plot_mesh(V,T);
    quiver3(I(:,1),I(:,2),I(:,3),N_e(:,1),N_e(:,2),N_e(:,3),'Color',[0 1 0]), hold on;
    alpha(0.5);
    
end


end % select_edge_normals