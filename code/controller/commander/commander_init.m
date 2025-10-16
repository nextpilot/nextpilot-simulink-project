function commander_init()

nosave_oldpath = pwd;
cd(fileparts(mfilename('fullpath')));

% 私有数据（保存到mat）
commander_private();

% 参数（保存到sldd）
commander_params();

% 常量（保存到sldd）
commander_consts();

cd(nosave_oldpath);