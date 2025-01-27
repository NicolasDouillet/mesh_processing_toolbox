function [T_out, TF_out] = fill_mesh_holes_with_texture(V, T_in, TF_in, boundary, txt_boundary, max_perim_sz)
%% fill_mesh_holes_with_texture : function to fill holes in one given mesh with texture.
%
% Working principle : without vertex addition. If the surface is opened,
% its boundary is considered as its largest hole.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2023-2025.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3].
%       [| | |]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3].
%          [  |     |     |  ]
%
% - TF_in : input triangle texture.
%
% - boundary : cell array of positive integer row vectors double (vertex indices), the boundary and/or holes of the mesh.
%
% - txt_boundary : 
%
% - max_perim_sz : real scalar double, the maximum perimeter size admitted for the holes to fill.
%
%
%%% Output arguments
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]
%
% - TF_out : output triangle texture.


%% Body
tic;

if nargin < 7
   
    max_perim_sz = Inf; 
    
end

cross_prod = @(mat_boundary_backward,mat_boundary,mat_boundary_forward) cross(V(mat_boundary_forward,:)-V(mat_boundary,:),V(mat_boundary_backward,:)-V(mat_boundary,:),2);
dot_prod   = @(mat_boundary_backward,mat_boundary,mat_boundary_forward)   dot(V(mat_boundary_forward,:)-V(mat_boundary,:),V(mat_boundary_backward,:)-V(mat_boundary,:),2);

sgn = @(bov,cross_prod) sign(dot(cross_prod,repmat(bov,[size(cross_prod,1),1]),2));
edg_angle = @(sgn,cross_prod,dot_prod) atan2(sgn.*sqrt(sum(cross_prod.^2,2)),dot_prod);

% Curvature continuity condition
ccc = @(sgn,vertex_normals,cross_prod) atan2(sgn.*sqrt(sum(cross(vertex_normals,cross_prod).^2,2)),dot(vertex_normals,cross_prod,2));


nb_holes = size(boundary,1);
T_out = T_in;
TF_out = TF_in;
nb_added_tgl = 0;
N = vertex_normals(V,T_out,1,'norm');


for h = 1:nb_holes % loop on every holes                        
    
    mat_boundary     = cell2mat(boundary(h,:));
    mat_txt_boundary = cell2mat(txt_boundary(h,:));
    
    bound_nb_vtx = numel(mat_boundary);
    
    if bound_nb_vtx <= max_perim_sz % current hole perimeter (bound_nb_vtx) smaller than the max defined                                                                              
        
        bov = boundary_orientation_vector(mat_boundary,V);                                
        
        while bound_nb_vtx > 2 % smallest hole is a triangle (3 edges)                                                                                       
            
            mat_boundary_forward  = circshift(mat_boundary,-1);
            mat_boundary_backward = circshift(mat_boundary,1);
            
            mat_txt_boundary_forward  = circshift(mat_txt_boundary,-1);
            mat_txt_boundary_backward = circshift(mat_txt_boundary,1);
            
            c_prod = cross_prod(mat_boundary_backward,mat_boundary,mat_boundary_forward);                                
            d_prod = dot_prod(mat_boundary_backward,mat_boundary,mat_boundary_forward);           
            sgnv = sgn(bov,c_prod);                     
            edg_angl_list = edg_angle(sgnv,c_prod,d_prod);                       
            curv_conti_cond = ccc(sgnv,N(mat_boundary,:),c_prod);
            
            if isequal(sign(edg_angl_list),-ones(size(edg_angl_list,1),size(edg_angl_list,2)))
                
                mat_boundary = fliplr(mat_boundary);
                mat_boundary_forward = circshift(mat_boundary,-1);
                mat_boundary_backward = circshift(mat_boundary,1);
                
                mat_txt_boundary = fliplr(mat_txt_boundary);
                mat_txt_boundary_forward  = circshift(mat_txt_boundary,-1);
                mat_txt_boundary_backward = circshift(mat_txt_boundary,1);      
            
                c_prod = cross_prod(mat_boundary_backward,mat_boundary,mat_boundary_forward);                                                
                d_prod = dot_prod(mat_boundary_backward,mat_boundary,mat_boundary_forward);                
                sgnv = sgn(bov,c_prod);
                edg_angl_list = edg_angle(sgnv,c_prod,d_prod);
                curv_conti_cond = ccc(sgnv,N(mat_boundary,:),c_prod);
                
            end                                    
            
            criterion = edg_angl_list./curv_conti_cond;
            
            min_pos = min(criterion(criterion > 0));
            
            if ~isempty(min_pos)

                min_angle_id = find(criterion == min_pos(1,1));
                
            else 
                
                min_angle_id = 1; % special possible case of the last triangle; index of min doesn't matter
            
            end                  
                                                         
            if min_angle_id; min_angle_id = min_angle_id(1,1); end;                                    
            
            new_tgl = [mat_boundary_forward(min_angle_id), mat_boundary(min_angle_id), mat_boundary_backward(min_angle_id)];                                                
            T_out = add_triangles(new_tgl,T_out);
            
            new_txt_tgl = [mat_txt_boundary_forward(min_angle_id),... 
                           mat_txt_boundary(min_angle_id),...         
                           mat_txt_boundary_backward(min_angle_id)];  
            
            TF_out = add_triangles(new_txt_tgl,TF_out);
            
            % Update 2 vertex normals
            N(mat_boundary_backward(min_angle_id),:) = mean(face_normals(V,T_out(find_triangles_from_vertex_list(T_out,mat_boundary_backward(min_angle_id)),:)),1);
            N(mat_boundary_forward(min_angle_id),:)  = mean(face_normals(V,T_out(find_triangles_from_vertex_list(T_out,mat_boundary_forward(min_angle_id)),:)),1);   
            
            nb_added_tgl = nb_added_tgl + 1;
            mat_boundary(min_angle_id) = [];
            mat_txt_boundary(min_angle_id) = [];
            bound_nb_vtx = numel(mat_boundary);
            
        end
                   
        boundary(h,:) = {mat_boundary}; % empty if less than 3 vertices
        txt_boundary(h,:) = {mat_txt_boundary};
        
    end
        
end

fprintf('%d hole(s) filled by adding %d triangles in %d seconds.\n',nb_holes,nb_added_tgl,toc);


end % fill_mesh_holes_with_texture


%% boundary_orientation_vector subfunction
function bov = boundary_orientation_vector(mat_boundary,V)

nb_edg = numel(mat_boundary); 

bov = cross(mean(V(mat_boundary(1,2:floor(0.5*nb_edg)),:)-repmat(V(mat_boundary(1,1),:),[floor(0.5*nb_edg)-1,1]),1),...
            mean(V(mat_boundary(1,ceil(0.5*nb_edg):end),:)-repmat(V(mat_boundary(1,1),:),[nb_edg-ceil(0.5*nb_edg)+1,1]),1),2);

end % boundary_orientation_vector