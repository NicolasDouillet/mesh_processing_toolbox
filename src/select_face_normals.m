function [N] = select_face_normals(V, T, mode, option_display)
%% select_face_normals : function to display the face normals on the mesh.
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
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
% - mode : character string in the set : {'raw','norm'*,'RAW','NORM'}, the variable deciding
%          wether to normalize or not the vertex normals. Case insensitive.
%
% - option_display : logical *true/false | *1/0, enable/disable the diplay.
%
%
% Output argument
%
%       [ |  |  |]
% - N : [Nx Ny Nz], real matrix double, the face normal vectors, size(N) = [nb_triangles,3].
%       [ |  |  |]


%% Body
if nargin < 4
    
    option_display = true;
    
    if nargin < 3
        
        mode = 'norm';
        
    end
    
end

N = compute_face_normals(V,T,mode);
G = cell2mat(cellfun(@(r) mean(V(r,:),1),num2cell(T,2),'un',0));

if option_display
    
    plot_mesh(V,T);
    quiver3(G(:,1),G(:,2),G(:,3),N(:,1),N(:,2),N(:,3),'Color',[1 1 0]), hold on;
    alpha(0.5);
    
end


end % select_face_normals