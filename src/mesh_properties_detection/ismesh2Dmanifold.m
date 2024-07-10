function [b, nmnfld_edg_id] = ismesh2Dmanifold(V, T)
%% ismesh2Dmanifold : boolean state function to test
% wether the mesh is 2D-manifold or not.
%
% Author : nicolas.douillet (at) free.fr, 2020-2024.
%
%
% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%
% Output arguments
%
% - b : logical true/false, the 2D-manifoldness result.
%
% - nmnfld_edg_id : positive integer column vector double, the index list of
%                    non manifold edges in the edge list.


%% Body
tic;

% Part I : check for non manifold edges
b = true;
nmnfld_edg_nb = 0;
nmnfld_edg_id = [];

edg_list = query_edges_list(T,'raw');
tgl_id_list = find_triangle_indices_from_edges_list(T,edg_list);

for n = 1:size(tgl_id_list,1)
    
    if numel(cell2mat(tgl_id_list(n,1))) > 2 % non manifold edge
        
        nmnfld_edg_nb = nmnfld_edg_nb + 1;
        nmnfld_edg_id = cat(2,nmnfld_edg_id,n);
        b = false;
        
    end
    
end


% Part II : check for non manifold vertices
vtx_id = (1:size(V,1))';
edg_lists = find_edges_from_vertex_list(T,vtx_id);

% Nb linked edgeS per vertex
vtx_ngb_edg_nb = cellfun(@(c) size(c,1),edg_lists);

% Nb linked triangles per vertex
tgl_id_list = find_triangle_sets_from_vertex_list(T,vtx_id);
vtx_ngb_tgl_nb = cellfun(@(c) numel(c),tgl_id_list);

nmnfld_vtx_id = find(vtx_ngb_edg_nb > vtx_ngb_tgl_nb+1);
[V_test,~] = remove_vertices(nmnfld_vtx_id,V,T,'indices');
nmnfld_vtx_nb = size(V,1)-size(V_test,1);


if nmnfld_vtx_nb > 0; b = false; end;


if b
    
    fprintf('%d non manifold edge and %d nonmanifold vertex detected. Mesh is 2D-manifold.\n',nmnfld_edg_nb,nmnfld_vtx_nb);
    
else % if ~b
    
    fprintf('%d non manifold edges and %d non manifold vertices detected. Mesh is not 2D-manifold.\n',nmnfld_edg_nb,nmnfld_vtx_nb);
    
end


fprintf('is2Dmanifold request executed in %d seconds.\n',toc);


end % ismesh2Dmanifold