function nextpilot_project_startup()

% 可以通过Simulink.fileGenControl控制simulink缓存和代码生成文件路径
%
% CacheFolder - 指定用于仿真的模型编译工件（包括 Simulink®缓存文件）的根文件夹。
% CodeGenFolder - 指定代码生成文件的根文件夹。
% CodeGenFolderStructure - 控制代码生成文件夹中的文件夹结构。

% rootpath = slproject.getCurrentProject().RootFolder;
% rootpath = matlab.project.rootProject().RootFolder;
rootpath = currentProject().RootFolder;

% 读取机架数据
% nextpilot_airframe_init();

% 读取控制数据
% nextpilot_controller_init();

% 切换到工程根目录
cd(rootpath)
