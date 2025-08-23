function dha = dihedral_angle(T, N, edge)
%% dihedral_angle : function to compute the dihedral angle
% between to adjacent faces.
%
% Requirements :
%
% - 2D-manifold mesh;
% - Coherently oriented face normals.
%
% dha : angle in radian unit
%
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.


%% Body
ctgls = find_triangle_indices_from_edg_list(T,edge);
dha = zeros(size(ctgls,1),1);

for k = 1:size(ctgls,1)
    
    tgls = cell2mat(ctgls(k,1));
    
    if numel(tgls) == 2
        
        dha(k,1) = pi - atan2(sqrt(sum(cross(N(tgls(1),:),N(tgls(2),:),2).^2,2)),dot(N(tgls(1),:),N(tgls(2),:)));
        
    else % numel(tgls) ~= 2 % no relevant dihedral angle (boundary or non manifold edge)
        
        dha(k,1) = Inf;
        
    end
    
end


end % dihedral_angle