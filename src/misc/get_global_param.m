function param = get_global_param()
%% get_global_param : function to get global parameters.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.
%
%
%%% Output argument
%
% param : struct of 4 fields : epsilon (scalar double), call_mode (char),
%                              sort_mode (char), bound_mode (char).


%% Body
fields = ["epsilon", "call_mode", "sort_mode", "bound_mode"];
param = struct('epsilon',[], 'call_mode',[], 'sort_mode',[], 'bound_mode',[]);
fid = fopen('global_parameters.txt','r'); % location = 'mesh_processing_toolbox\src\misc'
tline = fgetl(fid);

while strcmp(tline(1),'#')
    
    tline = fgetl(fid);
    
end

param.epsilon = str2double(deblank(tline));
tline = fgetl(fid);

for k = 2:numel(fieldnames(param))
       
    while strcmp(tline(1),'#')
       
        tline = fgetl(fid);
        
    end
    
    param.(char(fields(k))) = deblank(tline);       
    tline = fgetl(fid);
    
end

fclose(fid);


end % get_global_param