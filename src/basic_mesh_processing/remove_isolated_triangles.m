function [V_out, T_out] = remove_isolated_triangles(V_in, T_in, rm_isl_vtx)
%% remove_isolated_triangles : function to remove isolated triangles from the mesh
% (triangles which don't share any edge with the other triangles of the
% mesh (i.e : no neighbor triangle).
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
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
% - rm_isl_vtx : logical true/false, remove or not the resulting isolated vertices.
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
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3],
%           [  |      |      |   ]
%
%           where nb_output_triangles = nb_input_triangles - nb_isolated_triangles.


%% Body
% tic;

if nargin < 3
   
    rm_isl_vtx = true; % default behaviour
    
end

ngb_T = find_neighbor_triangle_indices(T_in); % 'all' % cell array ; global version
isl_tgl_id = cellfun(@(c) isempty(c),ngb_T);
T_out = T_in;
T_out(isl_tgl_id,:) = [];

if rm_isl_vtx
   
    [V_out,T_out] = remove_unreferenced_vertices(V_in,T_out);
    
else
    
    V_out = V_in;
    
end

% fprintf('%d isolated triangles removed in %d seconds.\n',size(T_in,1)-size(T_out,1),toc);


end % remove_isolated_triangles