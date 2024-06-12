Please first check the doc tab on the right to get some relevant and use examples of this toobox functions.

Please don'tforget ta rate if this code helped you. Thanks ! ;-)


%% DESCRIPTION

This package is a mesh processing toolbox which aim at providing a command line mesh lab in Matlab(R) console. It is designed to deal with and process 3D triangular meshes.
Quadrangular meshes as well as edge lists are also possible inputs thanks to "quad2trimesh" and "rebuild_triangulation_from_edge_list" conversion functions. For 2D
mesh processing, you can just set Z to zeros vector.


%% HELP

A basic help is included in the header of each source file. It especially includes input and output arguments precise descriptions (role, class, size, etc).
Just like for any Matlab (R) function, typewrite "help my_mesh_processing_file" in Matlab console to access it.


%% DATA FORMATS & HYPOTHESIS ON THE MESH

Most of the functions included take very common and widely used data structures as inputs and outputs :

- V : the vertex set / point cloud. Real matrix of double. size(V) = [nb_vertex,3].
- T : the triangulation / triangle set. Positive integer matrix of double. size(T) = [nb_triangles,3].
- E : the edge set. Positive integer matrix of double. size(T) = [nb_edges,2].

where :

- A vextex is a 1 x 3 row double vector of real numbers.
- A triangle (or a triplet) is a 1 x 3 row double vector of positive integers.
- An edge is a 1 x 2 row double vector of positive integers.

By default, and unless exceptions, vertex and triangle arguments are index based.

Another common argument is ngb_degre which corresponds to the neighborhood degre whished on the mesh, and which is used to find one vertex neighborhood.
For commun usages, this value is in the range |[1 ; 4]|. Tune it relatively to the local curvature of your mesh.


%% TESTS

Use .mat data files provided in /data for test and example files.
Most of the functions and every important ones have been tested in a dedicated file named : test_my_function.m.
Note that no mesh reader or writer is provided in this toolbox since there already exist enough satisfying ones coded in Matlab.
Look for : read_ply.m, write_ply.m, read_off.m, write_off.m, plyread.m, plywrite.m
Then to create your own .mat file for vertex set V and triangle set T, just use the command save('path_to_my_file/my_file.mat','V','T');


%% COPYRIGHT & SUPPORT

All the code included in this toolbox is the result of my unique personal own work and effort on the period 2020-2023, and going on for upcoming updates.

Each one of the algorithms / functions included have been independently tested, however I cannot provide any warrantee of any kind about them. Use them at your own risks.
Downloading and using this toolbox or just part of it assume you to have read and accept all the condition in this current description. 

This toolbox and its content is free of use and distribution with the following condition :
this description_read_me file must be included as well as each function header must be preserved.

SELLING THIS WHOLE TOOLBOX OR EVEN PARTS OF IT IS STRICLY PROHIBITED.

Modification of any kind are done under your own, only, and unique responsability.

Please report me any bug (with data set used and Matlab(R) code attached) or suggestion at nicotangente (at) free.fr


%% KNOWN LIMITATIONS

Though each function is vectorized at maximum, this toolbox do not use nearest neighbor searcher yet,
so main limitations consist in CPU time and data volume, especially for Matlab (R) display functions.

For this reason, appropriate usage of this toolbox is for light / medium size mesh processing (< 50k triangles).

One of the main limitations known yet is the algorithm in remove_self_intersecting_triangles for large meshes,
since the number of possible triangle pair combinations grows very quickly.

For a similar reason ismesh2Dmanifold function is also pretty CPU time consuming.

fill_mesh_holes_and_boundary algorithm doesn't yet prevent from creating self intersecting faces.

clone_solve_nmnfld_vertices may create flat triangle(s). I still have to figure out why and how to avoid it.
However it is still possible to remove them a posteriori with the function remove_flat_triangles.

Curvature computation algorithm is a homemade temporary version.
It is mostly efficient on regular meshes (where all faces have more or less the same size, and all the vertices have the same valence).

The two convex hull algorithms are mostly here for the demo and pedagogic purposes.
They are indeed slower than Matlab (R) compiled binaries used for th convex hull.

The function dual_of_trimesh mostly works on quasi planar triangular meshes.


%% MISC INFORMATION

Most of the time, I did my best to make function names pretty explicit in english.

By default, vertex and face normals are normalized at the same time they are computed.

Basic 3D mathematical computation algorithm (like point_to_plane_distance) are also independently available with their documentations in my file exchange contributions.

I especially thank William V, Binbin Qi, for what they taught me while solving my cody problems.
Matlab users, your advices and tips to improve and speed up my algorithms are welcome !

If you can’t see the mesh while plotting it, try ‘shading flat’ (it may be shadowed by its numerous dark edges).

Difference between find_triangles_from_vertex_list and find_triangle_sets_from_vertex_list functions is that in the first case
all triangle indices are put together in a matrix container, whereas in the second case they are sorted by vertex in a cell array. 

Difference between show functions and select functions is that the last ones return the selected object as an output (whereas show functions return nothing).

Gargoyle meshed models are provided courtesy of VCG-ISTI by the AIM@SHAPE-VISIONAIR Shape Repository.

Armadillo and bunny are simplified versions of the ones you can find on Stanford 3D scanning repository : https://graphics.stanford.edu/data/3Dscanrep/
Since I am not native english speaker, please forgive my langage approximations.

Matlab release version used for development and tests : R2019b.


Last update : 10 / 04 /2024.