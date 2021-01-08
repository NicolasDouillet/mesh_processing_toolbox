function [V_out, T] = quick_hull(V_in)
%% quick_hull : function to compute the 3D convex hull of
% a given point cloud with the divide & conquer algorithm.
%
% Author & support nicolas.douillet (at) free.fr, 2020.
%
%
% Input argument
%
%          [| | |]
% - V_in = [X Y Z], real matrix double, the input point set, size(V_in) = [nb_input_vertices,3].
%          [| | |]
%
%
% Output argument
%
%           [| | |]
% - V_out = [X Y Z], real matrix double, the out_put point set, size(V_out) = [nb_output_vertices,3].
%           [| | |]
%
%       [ |  |  |]
% - T = [i1 i2 i3], positive integer matrix double, the convex hull triangulation, size(T) = [nb_triangles,3].
%       [ |  |  |]


%% Body
tic
assert(size(V_in,1) > 3,'Error : vertex set V_in must contain at least four non coplanar vertices to be 3D.');

epsilon = 1e8*eps; % floating point tolerance error
nb_vtx = size(V_in,1);

f_Xmin = find(V_in(:,1) == min(V_in(:,1)));
f_Xmin = f_Xmin(1,1);
f_Ymin = find(V_in(:,2) == min(V_in(:,2)));
f_Ymin = f_Ymin(1,1);
f_Zmin = find(V_in(:,3) == min(V_in(:,3)));
f_Zmin = f_Zmin(1,1);
f_Xmax = find(V_in(:,1) == max(V_in(:,1)));
f_Xmax = f_Xmax(1,1);
f_Ymax = find(V_in(:,2) == max(V_in(:,2)));
f_Ymax = f_Ymax(1,1);
f_Zmax = find(V_in(:,3) == max(V_in(:,3)));
f_Zmax = f_Zmax(1,1);

bounding_box = [f_Xmin f_Xmax f_Ymin f_Ymax f_Zmin f_Zmax];
hull_vtx_idx = unique(bounding_box);

if numel(hull_vtx_idx) >= 4
   
    hull_vtx_idx = hull_vtx_idx(1,1:4);
    T = combnk(1:4,3);
        
elseif numel(hull_vtx_idx) == 3
    
    T = 1:3; 
    
else % if numel(hull_vtx_idx) < 3
    
    error('Colinear input point set.');
    
end

N = compute_face_normals(V_in(hull_vtx_idx,:),T,'norm');
    
% Avoid initial flat tetrahedron cases (octahedron example)
while isequal(N,repmat(N(1,:),[size(N,1),1]))
    
    hull_vtx_idx = [];
    
    while numel(hull_vtx_idx) < 4
        
        bounding_box = randi(nb_vtx,1,4);
        hull_vtx_idx = unique(bounding_box);        
        
    end
        
    N = compute_face_normals(V_in(hull_vtx_idx,:),T,'norm');
    
end

nb_t = 4;
hull_vtx_idx = hull_vtx_idx(1:nb_t);


T = nchoosek(hull_vtx_idx,3);
G = mean(V_in(hull_vtx_idx,:),1);
N = compute_face_normals(V_in,T,'norm');

% Orient normals outward
Gt = cell2mat(cellfun(@(r) mean(V_in(r,:),1),num2cell(T,2),'un',0));
orientation = sign(dot(N,Gt-repmat(G,[nb_t,1]),2));

if ~isequal(orientation,ones(nb_t,1)) && ~isequal(orientation,zeros(nb_t,1))
    N = N.*orientation;
    T(orientation < 0,:) = fliplr(T(orientation < 0,:));
end

[V_out,T] = remove_inside_pts(V_in,T,epsilon);
nb_new_tgl = true;


while nb_new_tgl
    
    curr_tgl_idx = 1;
    nb_new_tgl = 0;
    
    while curr_tgl_idx < 1 + size(T,1)
                
        [T,N,new_vtx_idx] = grow_tetrahedron(V_out,T,N,curr_tgl_idx,epsilon);
        
        if new_vtx_idx % effective grow with new triangles
                              
            nb_new_tgl = nb_new_tgl + 2;
            edg_list = query_edges_list(T,'sorted');
            i = 1;
            
            while i < 1 + size(edg_list,1)
                
                tgl_pair_idx = cell2mat(find_triangle_indices_from_edges_list(T,edg_list(i,:)));                
                isconcave = detect_concavity(V_out,T,N,tgl_pair_idx,epsilon);
                
                if isconcave
                    
                    [T,N,edg_list] = flip_two_ngb_triangles(tgl_pair_idx,T,V_out,N,edg_list);
                    
                else
                    
                    i = i + 1;
                    
                end
                
            end
            
            [V_out,T] = remove_inside_pts(V_out,T,epsilon);            
            curr_tgl_idx = curr_tgl_idx - 1;
                        
        end
        
        curr_tgl_idx = curr_tgl_idx + 1;
        
    end       
    
end

fprintf('Mesh quick hull computed in %ds.\n',toc);


end % quick_hull


%% grow_tetrahedron subfunction
function [T, N, new_vtx_idx] = grow_tetrahedron(V, T, N, tgl_idx, epsilon)
% grow_tetrahedron : function to find one
% new vertex belonging to the convex hull
% for one given triangle, to create the three
% newborn triangles and erase the previous one.


new_vtx_idx = [];
nb_vtx = size(V,1);

d = dot(repmat(N(tgl_idx,:),[nb_vtx,1]),V,2);

if find(abs(d) > epsilon)
    
    f = find(d == max(d));    
    
    if f & ~ismember(f,unique(T(:))) % prevent from creating non manifold stuffs
        
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


%% detect_concavity subfunction
function [isconcave] = detect_concavity(V, T, N, tgl_pair_idx, epsilon)
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

isconcave = sign(dot(n1+n2,H2-H1,2)) > epsilon;


end % detect_concavity


%% flip_two_ngb_triangles subfunction
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


%% remove_inside_pts subfunction
function [V_out, T] = remove_inside_pts(V_in, T, epsilon)
% remove_inside_pts : function to remove points inside the convex hull
% during its computational iterations to save cpu time.


in_vtx_set_idx = find(isin3Dconvexset(V_in,T,V_in,epsilon));

if ~isempty(in_vtx_set_idx)
    
    [V_out,T] = remove_vertices(in_vtx_set_idx,V_in,T,'indices');
    
else
    
    V_out = V_in;
    
end


end % remove_inside_pts