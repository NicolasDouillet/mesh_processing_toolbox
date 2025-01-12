function [] = reset_global_param()
%% reset_global_param : function to reset global parameters.
%
%%% Author : nicolas.douillet9 (at) gmail.com, 2025.


param = struct('epsilon',eps("double"),...
               'call_mode','index',...
               'sort_mode','raw',...
               'bound_mode','closed');
           
set_global_param(param);


end % reset_global_param