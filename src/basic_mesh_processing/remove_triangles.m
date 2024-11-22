function T_out = remove_triangles(T_in, T_set, mode)
%% remove_triangles : function to remove triangles (T_set) from the triangle set (T_in).
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
%           [|  |  | ]
% - T_set = [i1 i2 i3], positive integer matrix double, the triangle set, size(T_set) = [nb_triangles,3], 
%           [|  |  | ]
%
%           or integer vector of indices, size(T_set) = [1,nb_triangles]. NB : in the case size(T_set) = [1,3]
%           the difference between the two possible options is only made thanks to the input argument mode value.
%
% - mode : character string in the set {'index','explicit',INDEX,'EXPLICIT'}. Case insensitive.
% 
%
%%% Output argument
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3],
%           [  |      |      |   ]
%
%           with nb_output_triangles = nb_input_triangles - nb_removed_triangles.


% tic;


%% Input parsing
if nargin < 3

    mode = 'index'; % default behaviour
    
end


%% Body
T_out = T_in;

if strcmpi(mode,'index') && ismember(1,size(T_set))
       
    T_out(T_set,:) = [];
    
elseif strcmpi(mode,'explicit') && size(T_set,2) == 3
    
    T_out = setdiff(T_in,T_set,'rows','stable'); % TODO : pre sort of each container ?
    
else
    
    error('mode value must be either set to ''index'' with T_set a one row/column vector or to ''explicit'' with size(T_set,2) = 3.');
    
end

% fprintf('%d triangle(s) removed in %d seconds.\n',size(T_in,1)-size(T_out,1),toc);


end % remove_triangles