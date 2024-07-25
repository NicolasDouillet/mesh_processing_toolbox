function comp_area = component_area(V, C)
%% component_area : function to compute the area of every component of the mesh, in area unit.
%
% Author : nicolas.douillet9 (at) gmail.com, 2020-2024.
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
% - component_area : real double row vector, the mesh component area, in area unit. 
%                    size(component_area) = [1,nb_components].


%% Body
tic;
cc_nb = size(C,1); % number of connected components 
comp_area = zeros(1,cc_nb);

for k = 1:cc_nb        
    
    T = cell2mat(C(k,1));    
    cc_tgl_area = cellfun(@(r1,r2,r3) sqrt(sum(r1.^2,2))*point_to_line_distance(r2,r1,r3),...
                          num2cell(V(T(:,2),:)-V(T(:,1),:),2),num2cell(V(T(:,3),:),2),...
                          num2cell(V(T(:,1),:),2),'un',0);
                      
    comp_area(1,k) = 0.5*sum([cc_tgl_area{:}]);
    
end

fprintf('Component area computed in %d seconds.\n',toc);


end % component_area