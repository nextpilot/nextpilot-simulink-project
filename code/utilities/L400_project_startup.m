function L400_project_startup()

rootpath = slproject.getCurrentProject().RootFolder;

% 读取机架数据
cd(fullfile(rootpath,'airframe'))
L400_sdofplant_initdata;

% 读取控制数据
cd(fullfile(rootpath,'controller'))
% L400_sdofplant_initdata;

% 切换到工程根目录
cd(rootpath)
