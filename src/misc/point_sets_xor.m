function [V, id1, id2] = point_sets_xor(V1, V2, precision)
%% point_sets_xor : function to compute and return the
% exclusive union between the two point sets V1 and V2.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2024-2025.
%
%
%%% Input arguments
%
%        [  |   |   |]
% - V1 = [V1x V1y V1z], real row vector double, the first input point set. Size(V1) = [nb1_vertex,3]. Mandatory.
%        [  |   |   |]
%
%        [  |   |   |]
% - V2 = [V2x V2y V2z], real row vector double, the second input point set. Size(V2) = [nb2_vertex,3]. Mandatory.
%        [  |   |   |]
%
% - precision : real scalar double, the geometric precision function of eps. Optional.
%
%
%%% Output arguments
%
%       [ |  |  |]
% - V = [Vx Vy Vz], real row vector double, the output / intersecting point set. Size(V) = [nb_vertex,3].
%       [ |  |  |]
%
% - id1 : row vector of positive integers, the index vector such that V = V1(id1).
%
% - id2 : row vector of positive integers, the index vector such that V = V2(id2).


%% Body
if nargin  < 3
   
    precision = 1e3*eps; % default value
    
end

C1 = num2cell(V1,2);
C2 = num2cell(V2,2);

i1 = cellfun(@(r) find(all(abs(r - V1) < precision, 2)), C2,'un',0);
i1 = i1(~cellfun('isempty',i1));
i1 = unique(cell2mat(i1),'stable');
id1 = setdiff(1:size(V1,1),i1);

i2 = cellfun(@(r) find(all(abs(r - V2) < precision, 2)), C1,'un',0);
i2 = i2(~cellfun('isempty',i2));
i2 = unique(cell2mat(i2),'stable');
id2 = setdiff(1:size(V2,1),i2);

V = union(V1(id1,:),V2(id2,:),'rows');


end % point_sets_xor