function vtol50kg_airframe_gencode
% slbuild    为模型编译独立可执行文件或模型引用目标
% codebuild  编译和链接生成的代码
% rtwrebuild Rebuild generated code from model

model = "vtol50kg_airframe";

% 代码生成路径
genfolder = fullfile(currentProject().SimulinkCodeGenFolder, model + "_grt_rtw");
% 打包代码路径
packfile = fullfile(currentProject().SimulinkCodeGenFolder, model + ".zip");

% 获取模型状态，并尝试加载模型
isloaded = bdIsLoaded(model);
if ~isloaded
    load_system(model);
end
isdirty = bdIsDirty(model);

% 获取原始配置
old_cs = getActiveConfigSet(model);

% 创建代码生成配置
all_cs = getConfigSets(model);
if ~ismember('ert_generic', all_cs)
    new_cs = nextpilot_project_gencode_config;
    attachConfigSet(model, new_cs);
end

% 激活代码生成配置
setActiveConfigSet(model, 'ert_generic');

% 移除老的代码和临时文件
% if exist(genfolder, "dir")
%     rmdir(genfolder, 's')
% end
% if exist(packfile, "file")
%     delete(packfile)
% end

% try
%     cm = coder.mapping.api.get(model);
% catch
%     cm= coder.mapping.utils.create(model);
% end


% 生成代码
slbuild(model, 'GenerateCodeOnly', true)

% 打包代码
% load(fullfile(genfolder, "buildInfo.mat"), 'buildInfo');
% packNGo(buildInfo, 'packType', 'flat')
disp("生成路径：<a href=""matlab:winopen('" + genfolder + "')"">" + genfolder + "</a>")
disp("打包代码：<a href=""matlab:winopen('" + packfile + "')"">" + packfile  + "</a>")

% 恢复原始配置
setActiveConfigSet(model, get_param(old_cs, 'Name'));

% 保存和关闭模型
if ~isdirty
    save_system(model);
end

if ~isloaded
    close_system(model);
end
