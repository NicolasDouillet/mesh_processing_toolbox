function fa = face_angles(V, T, face_ids)
%% face_angles : function to compute the angles
% inside one or more given face.
%
%  Requirement :
%
% - T is a triangular mesh
%
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.


%% Body
vid = T(face_ids,:);

uAB = V(vid(:,2),:) - V(vid(:,1),:);
uBC = V(vid(:,3),:) - V(vid(:,2),:);
uCA = V(vid(:,1),:) - V(vid(:,3),:);

fa = cat(2,atan2(sqrt(sum(cross(uAB,-uCA,2).^2,2)),dot(uAB,-uCA,2)),...
           atan2(sqrt(sum(cross(uBC,-uAB,2).^2,2)),dot(uBC,-uAB,2)),...
           atan2(sqrt(sum(cross(uCA,-uBC,2).^2,2)),dot(uCA,-uBC,2)));


end % face_angles