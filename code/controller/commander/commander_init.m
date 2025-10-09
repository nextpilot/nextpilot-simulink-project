function commander_init()

nosave_oldpath = pwd;
cd(fileparts(mfilename('fullpath')));

% 模型私有数据
commander_model_init();

% 模型公共数据
commander_param_init();

cd(nosave_oldpath);