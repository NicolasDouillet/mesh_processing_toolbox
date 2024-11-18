function [T, V] = logical_XOR(T1, T2, V1, V2, precision)
% logical_XOR : function to perform the logical exclusive union of two meshes.
%
%%% Author : nicolas.douillet (at) free.fr, 2024.
%
%
%%% Input arguments
%        
%        [ |   |   | ]
% - T1 = [i11 i12 i13], positive integer matrix double, the first input triangulation, size(T1) = [nb_triangles_1,3].
%        [ |   |   | ]
%        
%        [ |  |  |]
% - V1 = [X1 Y1 Z1], real matrix double, the first input point set, size(V1) = [nb_vertices_1,3].
%        [ |  |  |]
%
%        [ |   |   | ]
% - T2 = [i21 i22 i23], positive integer matrix double, the second input triangulation, size(T2) = [nb_triangles_2,3].
%        [ |   |   | ]
%
%        [ |  |  |]
% - V2 = [X2 Y2 Z2], real matrix double, the second input point set, size(V2) = [nb_vertices_2,3].
%        [ |  |  |]
%
% - precision, real positive scalar double, the precision used to compare X,Y,Z coordinate values between the two point sets V1 and V2.
%   Optional but mandatory if V2.
%
%
%%% Output arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the output point set, size(V) = [nb_vertices,3],
%       [| | |]
%
%       with nb_vertices = nb_vertices_1 + nb_vertices_2.
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the output triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]
%
%       with nb_triangles = nb_triangles_1 + nb_triangles_2.


% Body
% tic;

if nargin < 4 % one unique point set
    
    V = V1;
    T = setxor(sort(T1,2),sort(T2,2),'rows');
    
elseif nargin > 3 % two distinct point sets
    
    if nargin > 4
        
        [V,i1,i2] = point_sets_xor(V1,V2,precision);
        tgl_id_list1 = find_triangles_from_vertex_list(T1,i1);
        T = T1(tgl_id_list1,:);
        
        % Test / version avec diff de OR par AND
        
        
        % Il faut maintenant réindexer T1 et T2 sur V, comme pour le AND                        
        %         if ~isempty(V)
        %
        %             % Common vertices
        %
        %             % À vérifier !
        %             [~,id1] = point_sets_xor(V1,V,precision);
        %             [~,id2] = point_sets_xor(V2,V,precision);
        %
        %             % Clean triangulations from out of intersection vertices
        %             out_vtx_id1 = setdiff((1:size(V1,1))',id1);
        %             out_vtx_id2 = setdiff((1:size(V2,1))',id2);
        %
        %             extra_tgl_id1 = find_triangles_from_vertex_list(T1,out_vtx_id1);
        %             extra_tgl_id2 = find_triangles_from_vertex_list(T2,out_vtx_id2);
        %
        %             % Suppress triangles which have -at least- one index out of V
        %             T1(extra_tgl_id1,:) = [];
        %             T2(extra_tgl_id2,:) = [];
        %
        %             % Triangulations reindexing according to V naturel indices / order
        %             M1 = containers.Map(id1',1:numel(id1));
        %             M2 = containers.Map(id2',1:numel(id2));
        %
        %             [H1,W1] = size(T1);
        %             T1 = T1(:);
        %             T1 = num2cell(T1(:));
        %
        %             [H2,W2] = size(T2);
        %             T2 = T2(:);
        %             T2 = num2cell(T2(:));
        %
        %             T1 = values(M1,T1);
        %             T2 = values(M2,T2);
        %
        %             TX1 = reshape(cell2mat(T1),[H1,W1]);
        %             TX2 = reshape(cell2mat(T2),[H2,W2]);
        %
        %             T = intersect(sort(TX1,2),sort(TX2,2),'rows','stable');
        %
        %         else % empty intersection
        %
        %             T = [];
        %
        %         end
        
        
        
        %         % Seek and add triangle third vertices belonging to the
        %         % corresponding triangulation (boundary ones)
        %         tgl_id_list1 = find_triangles_from_vertex_list(T1,i1);
        %         tgl_id_list2 = find_triangles_from_vertex_list(T2,i2);
        %
        %         T = union(T1(tgl_id_list1,:),T2(tgl_id_list2,:),'rows');
        
                
        
    elseif nargin < 5
        
        error('extra argument precision required to compare two different point sets.');
        
    end
    
end

% fprintf('Mesh exclusive union performed in %d seconds.\n',toc);


end % logical_XOR


%         [T_AND,V_AND] = logical_AND(T1,T2,V1,V2,precision);
%         [T_OR,V_OR]   = logical_OR(T1,T2,V1,V2,precision);
%         T = setdiff(sort(T_OR,2),sort(T_AND,2),'rows');
%
%
%         V = setdiff(V_OR,V_AND,'rows','stable'); % doesn't work if the two triangulations actually are identical / the same