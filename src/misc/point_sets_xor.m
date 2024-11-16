function [V, i1, i2] = point_sets_xor(V1, V2, precision)
% point_sets_xor : function to compute and return the
% exclusive union between the two point sets V1 and V2.
%
%%% Author : nicolas.douillet (at) free.fr, 2024.


% Body
if nargin  < 3
   
    precision = 1e3*eps; % default value
    
end

C1 = num2cell(V1,2);
C2 = num2cell(V2,2);

i1 = cellfun(@(r) find(sum(abs(r - V1),2) < 3*precision), C2,'un',0); % todo : improve criterion
i1 = i1(~cellfun('isempty',i1));
i1 = unique(cell2mat(i1),'stable');

i2 = cellfun(@(r) find(sum(abs(r - V1),2) < 3*precision), C1,'un',0); % todo : improve criterion
i2 = i2(~cellfun('isempty',i2));
i2 = unique(cell2mat(i2),'stable');

V = union(V1(setdiff(1:size(V1,1),i1),:),...
          V2(setdiff(1:size(V2,1),i2),:));


end % point_sets_xor