function [] = show_triangle_selection(V, T, T_subset, mode)
%% show_triangle_selection : function to highlight a
% selection of triangles on the mesh.
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
% - T_subset : either positive integer row vector double* (the indices of the triangles; default behaviour) or
%              positive integer matrix double giving the explicit indices triplet list. In this latter case,
%              mode must be set to 'explicit'.
%
% - mode : character string in the set : {'explicit',indices,'EXPLICIT','INDICES'}. Explicit mode
%          corresponds to the case where T_subset is made of triangle vertices [i1 i2 i3] indices.
%          Case insensitive.


%% Body
assert(nargin > 2,'Not enough input argument. show_triangle_selection takes at least 3 input arguments.')

if nargin > 2
    
    if nargin > 3
        
        if strcmpi(mode,'indices')
            
            subset_idx = T_subset;
            
        elseif strcmpi(mode,'explicit')
            
            subset_idx = find(ismember(T,T_subset,'rows'));
                        
        end
        
    else
        
        % mode = 'indices'; % default behaviour
        subset_idx = T_subset;
        
    end
    
    if subset_idx > 0 && max(subset_idx) < 1+size(T,1)
        
        T_subset = T(subset_idx,:);
    
    else
       
        error('One or more indices submitted out of the range |[1; nb_triangles]|.');
        
    end
    
else
    
    T_subset = T;
    
end
    
plot_mesh(V,T);
trisurf(T(T_subset,:),V(:,1),V(:,2),V(:,3),'FaceColor',[1 0 0]); hold on;


end % show_triangle_selection