function [V, T] = meshed_mtlb_logo()


c = 8; % 16 % number of samples / ~= mesh ddensity
Z = 160*membrane(1,c);

S = 2*c+1; % 2*c + 1 % nb samples on the side
[X,Y] = meshgrid(1:S,1:S);

V = cat(2,X(:),Y(:),Z(:));
t_idx = (1:S^2)';

% Create triangulation                                                                  |\
Tl = cat(2,t_idx(1:end-S-1),t_idx(2:end-S),t_idx(1+S:end-1)); % left oriented triangles |_\
%                                                                                      __
Tr = cat(2,t_idx(1+S:end-1),t_idx(2:end-S),t_idx(S+2:end)); % right oriented triangles \ |
%                                                                                       \|

f = find(mod(Tl(:,1),S) == 0);
Tl(f,:) = [];

g = find(mod(Tr(:,1),S) == 0);
Tr(g,:) = [];

T = cat(1,Tl,Tr); % size(T) must be = [8*c^2,3]


f = figure;
t = trisurf(T,X,Y,Z);
colormap(1-jet);
shading faceted;
axis square;
ax = gca;
ax.Clipping = 'off';

axis([1 2*c+1 1 2*c+1 -53.4 160]);
set(gcf, 'Color', [0 0 0]), set(ax,'Color',[0 0 0]);
axis off;
view(3);

l1 = light;
l1.Position = [160 400 80];

t.FaceColor = [1 1 0];
set(t,'LineWidth',2);

camlight right;
axis off
f.Color = 'black';