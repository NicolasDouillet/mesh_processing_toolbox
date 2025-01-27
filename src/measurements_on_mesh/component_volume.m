function component_volume = component_volume(V, C)
%% component_volume : function to compute volume per component.
% Components must be 2D-manifold closed watertight surfaces,
% and free of duplicated triangles.
% 
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
% - C : cell array of triangle sets (positive integer matrices), the components array. Mandatory.
%
%
%%% Output argument
%
% - component_volume : positive real row vector double, the vector of component volumes.


%% Body
tic;

cc_nb = numel(C);
component_volume = zeros(1,cc_nb);

for k = 1:cc_nb            
    
    R = cell2mat(C(k,1));
    
    component_volume(1,k) = abs(sum(cell2mat(cellfun(@(r)...
                            dot(cross(V(r(1,1),:),V(r(1,2),:),2),V(r(1,3),:),2),num2cell(R,2),...
                            'un',0))))/6;

end

fprintf('Component volume computed in %d seconds.\n',toc);


end % component_volume