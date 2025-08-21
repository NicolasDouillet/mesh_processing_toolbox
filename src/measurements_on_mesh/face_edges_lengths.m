function fel = face_edges_lengths(V, T, face_ids)
%% face_edges_lengths : function to compute the edges lengths
% of one ore more given face.
%
%  Requirement :
%
% - T is a triangular mesh
%
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.


%% Body
vid = T(face_ids,:);

fel = cat(2,sqrt(sum((V(vid(:,2),:) - V(vid(:,1),:)).^2,2)),...
            sqrt(sum((V(vid(:,3),:) - V(vid(:,2),:)).^2,2)),...
            sqrt(sum((V(vid(:,1),:) - V(vid(:,3),:)).^2,2)));


end % face_edges_lengths