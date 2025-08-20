function dha = dihedral_angle(T, N, edge)
%% dihedral_angle : function to compute the dihedral angle
% between to adjacent faces.
%
% Requirements :
%
% - 2D-manifold mesh;
% - Coherently oriented face normals.
%
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.


%% Body
tgls = cell2mat(find_triangle_indices_from_edg_list(T,edge));

if numel(tgls) == 2
         
    dha = atan2(norm(cross(N(tgls(1),:),N(tgls(2),:))),dot(N(tgls(1),:),N(tgls(2),:)));
    
else % no relevant dihedral angle
    
    dha = NaN;
    
end


end % dihedral_angle