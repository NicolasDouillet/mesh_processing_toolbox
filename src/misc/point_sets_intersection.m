function [V, i1] = point_sets_intersection(V1, V2, precision)
%% numeric_data_arrays_intersection : function to compute and return the
% intersection between the two point sets V1 and V2.
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
% - i1 : row vector of positive integers, the index vector such that V = V1(i1).


%% Body
if nargin  < 3
   
    precision = 1e3*eps; % default value
    
end

C2 = num2cell(V2,2);

i1 = cellfun(@(r) find(all(abs(r - V1) < precision, 2)), C2,'un',0);
i1 = i1(~cellfun('isempty',i1));
i1 = unique(cell2mat(i1),'stable');

V = V1(i1,:);


end % point_sets_intersection