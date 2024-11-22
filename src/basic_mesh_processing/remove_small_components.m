function [T_out, V_out] = remove_small_components(C, pct2rm ,V_in, rm_isl_vtx)
%% remove_small_components : function to remove from the mesh (C) components smaller
% (in relative number of triangles) than a certain percent of the total.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%
% - C : cell array of interger matrices, the components of the input triangulation.
%
% - pct2rm : positive integer scalar, the percentage under which a
%            component is suppressed. pct2rm € [0; 100].
%
%          [ |    |    |  ]
% - V_in = [X_in Y_in Z_in], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3].
%          [ |    |    |  ]
%
%
%%% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set, size(V_out) = [nb_output_vertices,3],
%           [  |     |     |  ]
%
%           where nb_output_vertices = nb_input_vertices - nb_vertices_removed.
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3],
%           [  |      |      |   ]
%
%           where nb_output_triangles = nb_input_triangles - nb_triangles_removed.


%% Body
tic;

if nargin < 4
   
    rm_isl_vtx = true; % default behaviour
    
end

comp_nb_tgl = cellfun(@(c) size(c,1),C);
total_nb_tgl = sum(comp_nb_tgl,1);
comp_pct_vect = round(100*comp_nb_tgl / total_nb_tgl);
nb_comp = numel(C);
C = C(comp_pct_vect >= pct2rm,1);
nb_rm_comp = nb_comp - numel(C);
T_out = cell2mat(C);

if rm_isl_vtx
   
    [V_out,T_out] = remove_unreferenced_vertices(V_in,T_out);
    
else
    
    V_out = V_in;
    
end

fprintf('%d component(s) smaller than %d percent of the total removed in %d seconds.\n',nb_rm_comp,pct2rm,toc);


end % remove_small_components