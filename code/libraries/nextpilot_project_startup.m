function nextpilot_project_startup()

rootpath = slproject.getCurrentProject().RootFolder;

% 读取机架数据
% nextpilot_airframe_init();

% 读取控制数据
% nextpilot_controller_init();

% 切换到工程根目录
cd(rootpath)
