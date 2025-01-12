function T_out = reorient_all_faces_coherently(V, T_in)
%% reorient_all_faces_coherently : function to flip
% the orientation of certain triangles of the mesh (T_in)
% in order to have a coherently oriented mesh as a result.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%       [| | |]
% - V = [X Y Z], real matrix double, the point set, size(V) = [nb_vertices,3]. Mandatory.
%       [| | |]
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3]. Mandatory.
%          [  |     |     |  ]
%
%
%%% Output argument
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Body
tic;

if ismesh2Dmanifold(V,T_in)
        
    [cc_nb,C_in] = segment_connected_components(T_in);
    C_out = cell(cc_nb,1);
    
    for n = 1:cc_nb % loop on nb connected components
        
        T_n = cell2mat(C_in(n,1));
        ngb_T = find_neighbor_triangle_indices(T_n); % 'all'
        oriented_tgl_id = 1; % Default seed triangle is #1
        t = 1; % nb processed / oriented triangles
        curr_tgl_id = oriented_tgl_id(t);
        curr_tgl = T_n(curr_tgl_id,:);
        
        while numel(oriented_tgl_id) < size(T_n,1) % some not oriented triangles remain
            
            ngb_tgl_id = cell2mat(ngb_T(curr_tgl_id,1))';
            ngb_triangles_2_orient = setdiff(ngb_tgl_id,oriented_tgl_id);
            
            % Orient its neighbor triangles if they are not alreay oriented
            for i = ngb_triangles_2_orient
                
                E_curr = query_edg_list(curr_tgl);
                Ei = query_edg_list(T_n(i,:));
                
                % hlf_cmn_edg = find(ismember(Ei,E_curr,'rows'), 1); % common half edge
                hlf_cmn_edg = find(all(bsxfun(@eq,Ei,E_curr),2)); % common half edge 
                
                if ~isempty(hlf_cmn_edg)
                    
                    T_n(i,:) = fliplr(T_n(i,:));
                    
                end
                
            end
            
            oriented_tgl_id = cat(2,oriented_tgl_id,ngb_triangles_2_orient);
            t = t + 1;
            curr_tgl_id = oriented_tgl_id(t);
            curr_tgl = T_n(curr_tgl_id,:);
            
        end
        
        C_out(n,1) = {T_n};        
        
    end
    
    T_out = cell2mat(C_out);
    
else
    
    error('Mesh has at least one non manifold component. Orientation is not possible. Please remove non manifold triangles and retry.');
    
end

fprintf('%d faces coherently oriented in %d seconds.\n',size(T_in,1),toc);


end % reorient_all_faces_coherently