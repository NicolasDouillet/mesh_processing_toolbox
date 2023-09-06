function T = build_mesh_from_edge_list(E) % unordered / disordered
%
% Author & support : nicolas (dot) douillet (at) free (dot) fr, 2023.

% trouver tous les cycles de vertex les plus courts (hypothèse : mesh is « clean » : pas de vertex célibataire, etc...)
% Doit pouvoir traiter les edges "inversés"

% Différents modes ? -> non

% Attention : un edge est commun à au moins deux triangles !


% Une maille = boucle la plus courte entre deux point (après l'edge
% lui-même évidemment !); chemin le plus court.

% Peut marcher si maillage homogène / mailles de tailles toutes égales et connues. (3, 5)

% - Commencer par les paires d'edges consécutifs (deux paires qui s'intersectent en un edge)
%
% - Puis les triplets (triangles) : trois edges et trois vertices exactement
% (alors que 4 vertices si triplet 'ouvert')
%
% - Quadruplets
% - Quintuplets, etc...
%
%
% Boucle / maille détectée si nb_vertex  = nb_edge




% TODO : tests !


n = 3; % number of vertices for a triangle base mesh
nb_edg = size(E,1);
% vtx_idx_list = unique(sort(E(:))');
i = 1;


while i < 1 + size(E,1) % tant que tous les edges n'ont pas été traités
          
    
    first_lvl_edg_idx_list = find_linked_edge_indices(i,E);         
    
    
    second_lvl_edg_idx_list = cell(numel(first_lvl_edg_idx_list),1); % exclude first/starting edge    
    
    for k = first_lvl_edg_idx_list
       
        second_lvl_edg_idx_list(k,1) = setdiff(find_linked_edge_indices(k,E),i);
        
        
    end
    
    % second_lvl_vtx_idx_list = [second_lvl_edg_idx_list{:}];
    
    
    
    % Insert ascending order sorted triangle if it is not a duplicata
    
    
    i = 1 + mod(i,nb_edg);
    
end

% Remove duplicata
T = unique(sort(T,2),'rows');

end % build_mesh_from_edge_list


% TODO : + ngb_degre (1,2,3, etc)
function edg_idx_list = find_linked_edge_indices(edg_idx, E) % + link_degre
%
% Author & support : nicolas (dot) douillet (at) free (dot) fr, 2023.
 

nb_edg = size(E,1);
i = 1 + edg_idx;
edg_idx_list = [];


while i ~= edg_idx
       
    if ~isempty(intersect(E(edg_idx,:),E(i,:)))
        
        edg_idx_list = cat(2,edg_idx_list,i);
        
    end
    
    i = 1 + mod(i,nb_edg);
    
end


end % find_linked_edge_indices