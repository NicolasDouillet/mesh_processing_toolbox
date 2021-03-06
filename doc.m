%% mesh processing toolbox
%
% Author & support : nicolas.douillet (at) free.fr, 2020-2021.



%% Example #1 : vertex normals
addpath('data/');
addpath('src/');
load('icosahedron.mat');

ngb_degre = 1;
select_vertex_normals(V,T,ngb_degre);

%% Example #2 : non manifold triangles
load('kitten_nmnfld.mat');
nmnfld_tgl_idx_list = select_non_manifold_triangles(V,T);
view(0,90);

%% Example #3 : connected components
load('kitten_components.mat');

[cc_nb,components] = segment_connected_components(T);
show_mesh_components(V,components);
view(0,90);

%% Example #4 : holes and boundary selection
load('kitten_holed.mat');

nmnfld_vtx_idx = select_non_manifold_vertices(V,T,false);
[V,T] = clone_solve_nmnfld_vertices(V,T,nmnfld_vtx_idx);
boundaries = select_holes_and_boundary(V,T);
view(0,90);

%% Example #5 : hole filling
[V,T] = remove_non_manifold_vertices(V,T);
boundaries = select_holes_and_boundary(V,T);
view(-180,-90);

max_perim_sz = 200;
T = fill_mesh_holes(V,T,boundaries,'closed',max_perim_sz);
plot_mesh(V,T);
view(-180,-90);

%% Example #6 : curvature
load('kitten.mat');

ngb_degre = 2;
N = compute_vertex_normals(V,T,ngb_degre,'raw');
curvature = compute_mesh_curvature(V,T,N,ngb_degre,'mean');
show_mesh_curvature(V,T,curvature);
view(0,90);

%% Example #7 : subselection
load('Gargoyle_3k.mat');

plot_mesh(V,T);
view(-90,0);

n = [0 1 0];
I = [0 -25 800];
[V_out,T_out] = submesh_selection(V,T,n,I); %% Gargoyle top part 

plot_mesh(V_out,T_out);
view(-90,0);

%% Example #8 : smoothing
plot_mesh(V,T), shading interp, camlight right;
view(0,90);

N = compute_vertex_normals(V,T,2);
nb_iterations = 1;
ngb_degre = 1;
V = mesh_smooth(V,T,nb_iterations,ngb_degre);

plot_mesh(V,T), shading interp, camlight right;
view(0,90);

%% Example #9 : convex hull
nb_vtx = 128;
X = 2*(rand(nb_vtx,1)-0.5);
Y = 2*(rand(nb_vtx,1)-0.5);
Z = 2*(rand(nb_vtx,1)-0.5);

Rho = X.^2 + Y.^2 + Z.^2;
i = Rho <= 1;
X = X(i);
Y = Y(i);
Z = Z(i);
V = cat(2,X,Y,Z);

plot_point_set(V,'o','y',4);
axis equal;
view(3);

[V,Qh] = quick_hull(V);
plot_mesh(V,Qh);
axis equal;
view(3);

%% Example #10 : boundary smoothing
load('kitten_components.mat');

show_holes_and_boundary(V,T);
shading interp;
camlight right;
alpha(0.5);
view(3);
axis off;

boundaries = detect_mesh_holes_and_boundary(T);

nb_iterations = 2;
ngb_degre = 6;
V_out = smooth_mesh_boundaries(V,boundaries,nb_iterations,ngb_degre);

show_holes_and_boundary(V_out,T);
shading interp;
camlight right;
alpha(0.5);
view(3);
axis off;