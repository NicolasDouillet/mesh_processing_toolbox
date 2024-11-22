function boundaries = detect_mesh_boundary_and_holes(T)
%% detect_mesh_boundary_and_holes : function to detect vertices
% which are part of the mesh boundary and list their indices in
% boundary vectors. From the vertex and triangle lists, this
% function computes the mesh boundary when there are some
% (opened surface or presence of holes in the mesh).
% Principle is based on detecting and sorting non shared edges.  
%
%%% Author : nicolas.douillet (at) free.fr, 2020-2024.
%                                         
%
%%% Input arguments
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%
%%% Output argument
%
% - boundaries : cell array of positive integer row vectors double, size(boundaries) = [nb_holes,1].


%% Body
tic;

% Build  lists
raw_edges_list = query_edges_list(T);
sedges_list = sort(raw_edges_list,2);
[uedg_list,~,edg_id] = unique(sort(sedges_list,2),'rows');
[gc,gr] = groupcounts(edg_id);
uedg_id = gr(gc == 1);
uedg = uedg_list(uedg_id,:);
lone_edges_list = raw_edges_list(ismember(sedges_list,uedg,'rows'),:);
boundaries = {};

while ~isempty(lone_edges_list)
    
    first_vtx_id = lone_edges_list(1,1);
    nxt_vtx_id   = lone_edges_list(1,2);
    boundary = [first_vtx_id,nxt_vtx_id] ;
    lone_edges_list = lone_edges_list(2:end,:);
    
    % Nb holes / boundary times
    while nxt_vtx_id ~= first_vtx_id % && ~isempty(nxt_vtx_id)
                       
        i = find(any(lone_edges_list == nxt_vtx_id,2));
        nxt_edge = lone_edges_list(i,:);
        
        nxt_vtx_id = setdiff(nxt_edge,nxt_vtx_id); % must be the unique shared vertex beteween these two edges        
        
        % Fill boundary
        if ~isempty(nxt_vtx_id)
            boundary = cat(2,boundary, nxt_vtx_id);
        end
        
        % Update / dequeue lone_edges_list        
        lone_edges_list(i,:) = [];
        
    end
    
    if numel(unique(boundary)) > 2 % at least 3 different vertices
        boundaries = cat(1,boundaries, {boundary(1,1:end-1)});
    end
    
end


% Number of vertices descending order sort
bound_nb_vtx = zeros(size(boundaries,1),1);

for n = 1:size(boundaries,1)
    
    bound_nb_vtx(n,1) = numel(cell2mat(boundaries(n,1)));
    
end

[~,srt_id] = sort(bound_nb_vtx,'descend'); % ~ : srt_bound_nb_vtx
boundaries = boundaries(srt_id,:);
nb_holes = size(boundaries,1);

fprintf('%d boundaries detected in %d seconds.\n',nb_holes,toc);


end % detect_mesh_boundary_and_holes