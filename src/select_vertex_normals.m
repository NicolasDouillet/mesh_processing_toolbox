function [N] = select_vertex_normals(V, T, ngb_degre, mode, option_display)
%% select_vertex_normals : function to display the vertex normals on the mesh.
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
% - ngb_degre : positive integer scalar double in the range |[1; 6]|, the degre of
%               neighbors. Default value is 1.
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
% - N : [Nx Ny Nz], real matrix double, the vertex normalized normal vectors, size(N) = [nb_vertices,3].
%       [ |  |  |]


%% Body
if nargin < 5
    
    option_display = true;
    
    if nargin < 4
        
        mode = 'norm';
        
        if nargin < 3
            
            ngb_degre = 1;
            
        end
        
    end
    
end

N = compute_vertex_normals(V,T,ngb_degre,mode);

if option_display
    
    plot_mesh(V,T);
    quiver3(V(:,1),V(:,2),V(:,3),N(:,1),N(:,2),N(:,3),'Color',[1 0.5 0],'LineWidth',2), hold on;
    alpha(0.5);
    
end


end % select_vertex_normals