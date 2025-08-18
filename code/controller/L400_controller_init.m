function L400_controller_init()

oldpath = pwd;
newpath = fileparts(mfilename("fullpath") + ".m");
cd(newpath);

%% 导入用户自定义的参数
import_param_from_mfile(fullfile(newpath, '**/*_params.m'), 'L400_datadict.sldd')


%% 导入用户自定义的主题
import_uorb_message(fullfile(newpath, '**/*.msg'), 'L400_datadict.sldd')

cd(oldpath);