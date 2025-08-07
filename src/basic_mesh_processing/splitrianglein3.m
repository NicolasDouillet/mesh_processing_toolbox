function [V_out, T_out] = splitrianglein3(V_in, T_in, tid, vid, mode, V_new)
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
% - vid : integer scalar double, the index of the vertex to connect with. 1 <= vid <= size(V,1). Mandatory.
%         where V is the vertex set.
%
% - mode : character string in the set : {*'default','new'*,'DEFAULT','NEW'}, the option to set
%          to 'new' in case of the addition of a new vertex. Case insensitive. Optional.
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


%% Body

if nargin < 4 || strcmpi(mode,'defaut')
    
    V_out = V_in;       
    
elseif nargin > 3 && strcmpi(mode,'new')
    
    V_out = cat(1,V_in,V_new);
    vid = size(V_out,1); % overwrite given input vid whatever it was
            
end

% Create new triangles
new_tgl1 = cat(2,T_in(tid,1:2),vid);
new_tgl2 = cat(2,T_in(tid,2:3),vid);
new_tgl3 = cat(2,T_in(tid,3),T_in(tid,1),vid);

% Update triangulation
T_set = cat(1,new_tgl1,new_tgl2,new_tgl3);
T_out = add_triangles(T_set,T_in);
T_out = remove_triangles(T_out,tid);


end % splitrianglein3