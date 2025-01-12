function [] = set_global_param(param)
%% set_global_param : function to set global parameters.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.
%
%
%%% Input argument
%
% param : struct of 4 fields : epsilon (scalar double), call_mode (char),
%                              sort_mode (char), bound_mode (char). Mandatory.


%% Body
fields = ["epsilon", "call_mode", "sort_mode", "bound_mode"];
fid = fopen('global_parameters.txt','r+'); % location = 'mesh_processing_toolbox\src\misc'
tline = fgetl(fid);

while strcmp(tline(1),'#')
    
    pos = ftell(fid);
    tline = fgetl(fid);
        
end

space_block_length = numel(tline) - numel(num2str(param.epsilon));
fseek(fid,pos,'bof');

if space_block_length < 1 % no space completion

    fprintf(fid,'%s',num2str(param.epsilon));
    
else % if space_block_length > 1 % completion with spaces

    space_pad = repelem(' ',space_block_length);
    fprintf(fid,'%s',num2str(param.epsilon));
    fprintf(fid,'%s',space_pad);

end

pos = ftell(fid);
fseek(fid,2+pos,'bof');
tline = fgetl(fid);


for j = 2:numel(fieldnames(param))       
    
    while strcmp(tline(1),'#')
        
        pos = ftell(fid);
        tline = fgetl(fid);
        
    end
    
    space_block_length = numel(tline) - numel(param.(char(fields(j))));
    fseek(fid,pos,'bof');
    
    if space_block_length < 1 % no space completion
        
        fprintf(fid,'%s',param.(char(fields(j))));
        
    else % if space_block_length > 1 % completion with spaces
        
        space_pad = repelem(' ',space_block_length);
        fprintf(fid,'%s',param.(char(fields(j))));
        fprintf(fid,'%s',space_pad);
        
    end
    
    pos = ftell(fid);
    fseek(fid,2+pos,'bof');
    tline = fgetl(fid);
    
end


fclose(fid);


end % set_global_param