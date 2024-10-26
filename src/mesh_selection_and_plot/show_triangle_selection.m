function [] = show_triangle_selection(V, T, T_subset, mode)
%% show_triangle_selection : function to highlight a
% selection of triangles on the mesh.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
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
% - T_subset : either positive integer row vector double* (the indices of the triangles; default behaviour) or
%              positive integer matrix double giving the explicit indices triplet list. In this latter case,
%              mode must be set to 'explicit'.
%
% - mode : character string in the set : {'explicit',indices,'EXPLICIT','INDICES'}. Explicit mode
%          corresponds to the case where T_subset is made of triangle vertices [i1 i2 i3] indices.
%          Case insensitive.


%% Input parsing and body
if nargin > 2
    
    if nargin > 3
        
        if strcmpi(mode,'indices')
            
            subset_id = T_subset;
            
        elseif strcmpi(mode,'explicit')
            
            subset_id = find(all(bsxfun(@eq,T,T_subset),2));
                        
        end
        
    else
        
        % mode = 'indices'; % default behaviour
        subset_id = T_subset;
        
    end
    
    if subset_id > 0 && max(subset_id) < 1+size(T,1)
        
        T_subset = T(subset_id,:);
    
    else
       
        error('One or more indices submitted out of the range |[1; nb_triangles]|.');
        
    end
    
else
    
    T_subset = T;
    
end
    
plot_mesh(V,T);
trisurf(T(T_subset,:),V(:,1),V(:,2),V(:,3),'FaceColor',[1 0 0]); hold on;


end % show_triangle_selection