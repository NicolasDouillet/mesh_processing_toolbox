function [V_out, T_out] = splitrianglein3(V_in, T_in, tid, mode, vid, V_new)
%% splitrianglein3 : function to split one given triangle in three new
% triangles given the triangle id, the new vertex id in the point set, the
% triangulation, and the total number of vertices in the set including the
% new one. The triangle is deleted after the split.
%
% Property :
%
% - preserves normals orientation.
%
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2020-2025.
%
%
%%% Input arguments
%
%          [  |     |     |  ]
% - T_in = [i1_in i2_in i3_in], positive integer matrix double, the input triangulation, size(T_in) = [nb_input_triangles,3]. Mandatory.
%          [  |     |     |  ]
%
% - tid : integer scalar double, the index of the triangle to remove. 1 <= tid <= size(T_in,1). Mandatory.
%
% - mode : character string in the set : {*'default',*'DEFAULT','insert','INSERT','new','NEW'}, the option to set
%          to 'new' in case of the addition of a new vertex. Case insensitive. Optional.
%
% - vid : integer scalar double, the index of the vertex to connect with. 1 <= vid <= size(V,1). Mandatory.
%         where V is the vertex set.
%          
% - V_new = [Vx Vy Vz], real row vector double, the vertex to add. Size(V_new) = [1,3]. Optional.
%
%
%%% Output arguments
%
%           [  |     |     |  ]
% - V_out = [X_out Y_out Z_out], real matrix double, the output point set. Size(V_out) = [nb_output_vertices,3].
%           [  |     |     |  ]
%
%           [  |      |      |   ]
% - T_out = [i1_out i2_out i3_out], positive integer matrix double, the output triangulation, size(T_out) = [nb_output_triangles,3].
%           [  |      |      |   ]


%% Input parsing
if nargin < 4
    
    mode = 'default';           
    
elseif nargin > 3
    
    if strcmpi(mode,'insert')            
        
        if nargin < 5
            
            error('Not enough input arguments. Inside set vertex id is missing.');
            
        end
        
    elseif strcmpi(mode,'new')
        
        if nargin < 6
            
            error('Not enough input arguments. New vertex coordiantes are missing.');
            
        end
        
    elseif strcmpi(mode,'default')                
        
    else
        
        error('Unknown specified split mode.');
        
    end           
            
end


%% Body
V_out = V_in;
T_out = T_in; 
vk_id = [];

if strcmpi(mode,'default')
    
    for k = tid
        
        new_vtc_coord = mean(V_out(T_out(k,:),:),1);
        [V_out,vid] = add_vertices(new_vtc_coord,V_out);
        vk_id = cat(1,vk_id,vid);
        
    end
            
elseif strcmpi(mode,'insert')
    
    vk_id = vid';
    
elseif strcmpi(mode,'new')
    
    [V_out,vid] = add_vertices(V_new,V_out);
    vk_id = cat(1,vk_id,vid)';
    
end

% Create new triangles
new_tgl1 = cat(2,T_in(tid,1:2),vk_id);
new_tgl2 = cat(2,T_in(tid,2:3),vk_id);
new_tgl3 = cat(2,T_in(tid,3),T_in(tid,1),vk_id);

% Update triangulation
T_set = cat(1,new_tgl1,new_tgl2,new_tgl3);
T_out = add_triangles(T_set,T_in);
T_out = remove_triangles(T_out,tid);


end % splitrianglein3