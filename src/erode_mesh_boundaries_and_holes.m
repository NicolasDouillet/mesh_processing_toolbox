function [V_out, T_out] = erode_mesh_boundaries_and_holes(V_in, T_in, nb_it, mode)
%% erode_mesh_boundaries_and_holes : function to erode
% mesh boundaries and holes by vertex and triangle removal.
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2023.
%
%
% Input arguments
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3].
%          [ |    |    |  ]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
% - nb_it : positive integer scalar double, the number of iterations, the "depth" erosion level.
%
% - mode : character string in the set {'saw','smooth','SAW','SMOOTH'}, the erosion mode.
%          'saw' mode only removes edges of boundary and holes, whereas 'smooth' mode removes
%          edges and vertices. Aspect of the edges in 'saw' mode looks like /\/\/\, hence its name.          
%          
%
% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           where nb_output_vertices = nb_input_vertices - nb_duplicata.
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
tic

% Input parsing and defaultvalues
if nargin < 4
    
    mode = 'smooth';
    
    if nargin < 3
       
        nb_it = 1;
        
    end
    
end

V_out = V_in;
T_out = T_in;

for k = 1:nb_it
    
    raw_edges_list = query_edges_list(T_out);
    [~,~,iu] = unique(sort(raw_edges_list,2),'rows');
    
    % Unique edges only, even in mirror
    [i3,i4] = histc(iu,unique(iu));
    lone_edges_idx_vect = i3(i4) == 1;
    lone_edges_list = raw_edges_list(lone_edges_idx_vect,:);
    
    if strcmpi(mode,'smooth')
        
        bound_vertices = unique(lone_edges_list(:))';
        [V_out,T_out] = remove_vertices(bound_vertices,V_out,T_out,'indices');
        
    elseif strcmpi(mode,'saw')
        
        tgl_idx_list = cell2mat(find_triangle_indices_from_edges_list(T_out,lone_edges_list));
        T_out = remove_triangles(tgl_idx_list,T_out,'indices');
        
    end
    
end

fprintf('boundary and holes eroded in %d seconds.\n',toc);


end % erode_mesh_boundaries_and_holes