function [V,T] = quick_hull(V)
% quick_hull : function to compute the 3D convex hull of
% a given point cloud with the divide & conquer algorithm.
%
% Author & support nicolas.douillet (at) free.fr, 2020.
%
%
% Input argument
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%
% Output argument
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the convex hull triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]


tic
assert(size(V,1) > 3,'Error : vertex set V must contain at least four non coplanar vertices to be 3D.');

epsilon = 1e4*eps; % floating point tolerance error
nb_vtx = size(V,1);

% Template seed = tetrahedron centred in the unit sphere
v1 = [2*sqrt(2)/3,0,-1/3];
v2 = [-sqrt(2)/3,sqrt(6)/3,-1/3];
v3 = [-sqrt(2)/3,-sqrt(6)/3,-1/3];
v4 = [0 0 1];

% Look for OPi.vi max dot products
d1 = dot(V,repmat(v1,[nb_vtx,1]),2);
f1 = find(d1 == max(d1));
f1 = f1(1,1);

d2 = dot(V,repmat(v2,[nb_vtx,1]),2);
f2 = find(d2 == max(d2));
f2 = f2(1,1);

d3 = dot(V,repmat(v3,[nb_vtx,1]),2);
f3 = find(d3 == max(d3));
f3 = f3(1,1);

d4 = dot(V,repmat(v4,[nb_vtx,1]),2);
f4 = find(d4 == max(d4));
f4 = f4(1,1);

% 1st tetra
T = [f1 f3 f2;...
     f1 f2 f4;...
     f2 f3 f4;...
     f3 f1 f4];

% Original inside points removal
[V,T] = remove_inside_pts(V,T,epsilon);

nb_tgl = size(T,1);
curr_tgl_idx = 1; % loop on hull tgl idx
nb_new_tgl = 1; % to start with

N = compute_face_normals(V,T,'norm');
delta = det(N(1:3,:));

if abs(delta) < epsilon
    
    error('Coplanar or collinear input point set.');
    
end


while nb_new_tgl > 0 && curr_tgl_idx < 1 + size(T,1)
    
    [T,N,new_vtx_idx] = grow_tetrahedron(V,T,N,curr_tgl_idx);
    
    if new_vtx_idx % effective grow with new triangles
        
        edg_list = query_edges_list(T,'sorted');
        i = 1;
        
        while i < 1 + size(edg_list,1)
            
            tgl_pair_idx = cell2mat(find_triangle_indices_from_edges_list(T,edg_list(i,:)));            
            isconcave = detect_concavity(V,T,N,tgl_pair_idx);
            
            if isconcave
                
                [T,N,edg_list] = flip_two_ngb_triangles(tgl_pair_idx,T,V,N,edg_list);
                
            else
                
                i = i + 1;
                
            end
            
        end
        
        % Inside points removal
        [V,T] = remove_inside_pts(V,T,epsilon);
        curr_tgl_idx = curr_tgl_idx - 1;
        
    end
    
    curr_tgl_idx = curr_tgl_idx + 1;
    nb_new_tgl = size(T,1) - nb_tgl;
    nb_tgl = nb_new_tgl;
    
end

fprintf('Mesh quick hull computed in %ds.\n',toc);


end % quick_hull


function [T, N, new_vtx_idx] = grow_tetrahedron(V, T, N, tgl_idx)
% grow_tetrahedron : function to find one
% new vertex belonging to the convex hull
% for one given triangle, to create the three
% newborn triangles and erase the previous one.


new_vtx_idx = [];
nb_vtx = size(V,1);

d = dot(repmat(N(tgl_idx,:),[nb_vtx,1]),V,2); % ou calcul avec V-G_tgl et attention aux floating point errors...

if find(d > 0)
    
    f = find(d == max(d));
    f = setdiff(f,T(tgl_idx,:));
    
    if f % TODO : factorize with 1st if
        
        f = f(1,1);
        
        new_tgl1 = cat(2,T(tgl_idx,1:2),f);
        new_tgl2 = cat(2,T(tgl_idx,2:3),f);
        new_tgl3 = cat(2,T(tgl_idx,3),T(tgl_idx,1),f);
        
        % Add 3 new triangles and face normals
        T = cat(1,T,new_tgl1,new_tgl2,new_tgl3);
        new_face_normals = compute_face_normals(V,T(end-2:end,:),'norm');
        N = cat(1,N,new_face_normals);           
        
        % Remove one triangle and its normal
        T(tgl_idx,:) = [];        
        N(tgl_idx,:) = [];
        new_vtx_idx = f;                
        
    end
    
end


end % grow_tetrahedron


function [isconcave] = detect_concavity(V, T, N, tgl_pair_idx)
% detect_concavity : function to detect
% concave triangle pair configurations.


i1 = tgl_pair_idx(1);
i2 = tgl_pair_idx(2);

T1 = T(i1,:);
T2 = T(i2,:);

cmn_edg = intersect(T1,T2);
cross_edg = setdiff(union(T1,T2),cmn_edg);

H1 = mean(V(cmn_edg,:),1);
H2 = mean(V(cross_edg,:),1);

n1 = N(i1,:);
n2 = N(i2,:);

isconcave = sign(dot(n1+n2,H2-H1,2)) > 0;


end % detect_concavity


function [T, N, edg_list] = flip_two_ngb_triangles(tgl_pair_idx, T, V, N, edg_list)
% flip_two_ngb_triangles : function to flip
% two triangles sharing one common edge.


nb_vtx = size(V,1);

T1 = T(tgl_pair_idx(1),:);
T2 = T(tgl_pair_idx(2),:);

cmn_edg = intersect(T1,T2);                  % = new opposit vertices
new_cmn_edg = setdiff(union(T1,T2),cmn_edg); % = current opposit vertices


start_idx1 = find(ismember(T1,new_cmn_edg(1)),1,'first');
T1c = circshift(T1,-1);

if ~isempty(start_idx1)
    Ta = cat(2,new_cmn_edg(1),T1c(start_idx1),new_cmn_edg(2));
else
    start_idx1 = find(ismember(T1,new_cmn_edg(2)),1,'first');
    Ta = cat(2,new_cmn_edg(2),T1c(start_idx1),new_cmn_edg(1));
end


start_idx2 = find(ismember(T2,new_cmn_edg(2)),1,'first');
T2c = circshift(T2,-1);

if ~isempty(start_idx2)
    Tb = cat(2,new_cmn_edg(2),T2c(start_idx2),new_cmn_edg(1));
else
    start_idx2 = find(ismember(T2,new_cmn_edg(1)),1,'first');
    Tb = cat(2,new_cmn_edg(1),T2c(start_idx2),new_cmn_edg(2));
end

% Add 2 triangles and their face normals
T = add_triangles(Ta,T,nb_vtx);
T = add_triangles(Tb,T,nb_vtx);

% Remove 2 triangles and their face normals
T(tgl_pair_idx,:) = [];
new_face_normals = compute_face_normals(V,T(end-1:end,:),'norm');
N = cat(1,N,new_face_normals);
N(tgl_pair_idx,:) = [];
edg_list = cat(1,edg_list,sort(new_cmn_edg));
edg_list(all(bsxfun(@eq,edg_list,sort(cmn_edg)),2),:) = [];


end % flip_two_ngb_triangles


function [V, T] = remove_inside_pts(V, T, epsilon)
% remove_inside_pts : function to remove points inside the convex hull
% during its computational iterations to save cpu time.


in_vtx_set_idx = find(isin3Dconvexset(V,T,V,epsilon));

if ~isempty(in_vtx_set_idx)
    
    [V,T] = remove_vertices(in_vtx_set_idx,V,T,'indices');
    % fprintf('%d vertices removed.\n',numel(in_vtx_set_idx));
    
end


end % remove_inside_pts