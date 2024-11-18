function [V, i1] = point_sets_intersection(V1, V2, precision)
% numeric_data_arrays_intersection : function to compute and return the
% intersection between the two point sets V1 and V2.
%
%%% Author : nicolas.douillet (at) free.fr, 2024.


% Body
if nargin  < 3
   
    precision = 1e3*eps; % default value
    
end

C2 = num2cell(V2,2);

i1 = cellfun(@(r) find(all(abs(r - V1) < precision, 2)), C2,'un',0);
i1 = i1(~cellfun('isempty',i1));
i1 = unique(cell2mat(i1),'stable');

V = V1(i1,:);


end % point_sets_intersection