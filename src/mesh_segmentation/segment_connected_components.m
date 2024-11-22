function [cc_nb, components] = segment_connected_components(T, mode)
%% segment_connected_components : function to compute the number cc_nb of connected
% components and consequently segment the triangulation into cc_nb triangulation cells.
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
%%% Input arguments
%
%       [|  |  | ]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_input_triangles,3].
%       [|  |  | ]
%
% - mode : character string in the set {'explicit','index','EXPLICIT','INDEX'}, the format of each cell
%          content of output cell array components. In case mode is set to 'explicit', triangles are refered
%          as triplet lists of positive integer scalar double, whereas in case it is set to 'index', they are
%          just identified with their indices (positive integer scalar double). Case insensitive.
%
%
%%% Output arguments
%
% - cc_nb : positive integer scalar double, the number of connected components.
%
% - components : cell array of triangle sets (positive integer matrices double), the component array.


%% Input parsing
if nargin < 2
    
    mode = 'explicit'; % default
    
end


%% Body
tic;
components = {};
component = [];
cc_nb = 0; % hypothesis : T non empty

ngb_T = find_neighbor_triangle_indices(T); % 'all'
stored_tgl_id = 1; % Default seed triangle is #1
t = 1; % nb processed / stored triangles
curr_tgl_id = stored_tgl_id(t);


if strcmpi(mode,'explicit')
    
    component = cat(1,component,T(curr_tgl_id,:));
    
    while numel(stored_tgl_id) < size(T,1) % some unstored triangles remain
        
        % One same component
        while t < numel(stored_tgl_id) + 1 % ~isempty(idx_ngb_tgl_2_store)
            
            curr_tgl_id = stored_tgl_id(t);
            ngb_tgl_id = cell2mat(ngb_T(curr_tgl_id,1))';
            idx_ngb_tgl_2_store = setdiff(ngb_tgl_id,stored_tgl_id);
            component = cat(1,component,T(idx_ngb_tgl_2_store,:));
            stored_tgl_id = cat(2,stored_tgl_id,idx_ngb_tgl_2_store);
            t = t + 1;
            
        end
        
        components = cat(1,components,{component});        
        
        % New component
        component = [];
        cc_nb = cc_nb + 1;
        
        % New triangle seed : the first which is not in the list
        unstored_tgl_id = setdiff(1:size(T,1),stored_tgl_id);
        
        if ~isempty(unstored_tgl_id) % some unstored triangles remain
            
            curr_tgl_id = unstored_tgl_id(1,1); % default seed triangle is 1st of the list
            component = cat(1,component,T(curr_tgl_id,:));
            stored_tgl_id = cat(2,stored_tgl_id,curr_tgl_id);
            
        end
        
        if numel(stored_tgl_id) == size(T,1) % store last triangle
        
            if ~isempty(component)
                
                components = cat(1,components,{component});            
                cc_nb = cc_nb + 1;
                
            end
            
        end
        
    end
    
elseif strcmpi(mode,'index')
    
    component = cat(2,component,curr_tgl_id);
    
    while numel(stored_tgl_id) < size(T,1) % some unstored triangles remain
        
        % One same component
        while t < numel(stored_tgl_id) + 1 % ~isempty(idx_ngb_tgl_2_store)
            
            curr_tgl_id = stored_tgl_id(t);
            ngb_tgl_id = cell2mat(ngb_T(curr_tgl_id,1))';
            idx_ngb_tgl_2_store = setdiff(ngb_tgl_id,stored_tgl_id);
            component = cat(2,component,idx_ngb_tgl_2_store);
            stored_tgl_id = cat(2,stored_tgl_id,idx_ngb_tgl_2_store);
            t = t + 1;
            
        end
        
        components = cat(1,components,{component});        
        
        % New component
        component = [];
        cc_nb = cc_nb + 1;
                
        % New triangle seed : the first which is not in the list
        unstored_tgl_id = setdiff(1:size(T,1),stored_tgl_id);
        
        if ~isempty(unstored_tgl_id) % some unstored triangles remain
            
            curr_tgl_id = unstored_tgl_id(1,1); % default seed triangle is 1st of the list
            component = cat(2,component,curr_tgl_id);
            stored_tgl_id = cat(2,stored_tgl_id,curr_tgl_id);
            
        end
        
        if numel(stored_tgl_id) == size(T,1) % store last triangle
        
            if ~isempty(component)
                
                components = cat(1,components,{component});            
            
            end
            
        end
        
    end
    
end

fprintf('%d components found in %d seconds.\n',cc_nb,toc);


end % segment_connected_components