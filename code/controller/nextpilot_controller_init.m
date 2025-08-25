function nextpilot_controller_init()

oldpath = pwd;
newpath = fileparts(mfilename("fullpath") + ".m");
cd(newpath);

%% 导入用户自定义的参数
import_param_from_mfile(fullfile(newpath, '**/*_params.m'), 'nextpilot_datadict.sldd')


%% 导入用户自定义的主题
import_uorb_from_msg(fullfile(newpath, '**/*.msg'), 'nextpilot_datadict.sldd')

cd(oldpath);