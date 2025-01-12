% test get_set_global_param

clc;


addpath(genpath('../../src'));
addpath('../../data');

param = get_global_param()

new_param = struct('epsilon',1e9*eps, 'call_mode','explicit', 'sort_mode','sorted', 'bound_mode','opened');
set_global_param(new_param);

get_global_param()
reset_global_param();
get_global_param()