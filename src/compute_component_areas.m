function [component_area] = compute_component_areas(V, C)
%% compute_component_areas : function to compute the area of every component of the mesh, in area unit.
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
% - C : cell array of triangle sets (positive integer matrices double), the components array.
%
%
% Output argument
%
% - component_area : real double row vector, the mesh component areas, in area unit. 
%                    size(component_area) = [1,nb_components].


%% Body
tic;
cc_nb = size(C,1); % number of connected components 
component_area = zeros(1,cc_nb);

for k = 1:cc_nb        
    
    T = cell2mat(C(k,1));    
    cc_tgl_area = cellfun(@(r1,r2,r3) sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                          num2cell(V(T(:,2),:)-V(T(:,1),:),2),num2cell(V(T(:,3),:),2),...
                          num2cell(V(T(:,1),:),2),'un',0);
                      
    component_area(1,k) = 0.5*sum([cc_tgl_area{:}]);
    
end

fprintf('Component areas computed in %d seconds.\n',toc);


end % compute_component_areas