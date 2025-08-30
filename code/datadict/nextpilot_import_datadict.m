function nextpilot_import_datadict()

oldpath = pwd;
newpath = fileparts(mfilename("fullpath") + ".m");
cd(newpath);

sldd = 'nextpilot_datadict.sldd';

% 导入uorb消息
import_uorb_from_msg('uorb/v1.12.3/*.msg', sldd);
import_uorb_from_msg('mission/*.msg', sldd);

% 导入mavlink消息
import_mavlink_from_xml('mavlink/v1.0/common.xml', sldd);

% 导入param参数
import_param_from_json('param/parameters-v1.12.3.json', sldd);

%% 导入const常数
oldvar = who;
nextpilot_define_constant;
newvar = who;
addvar = setdiff(newvar, [oldvar;'oldvar']);

% 打开sldd文件
if exist(sldd, 'file')
    dobj = Simulink.data.dictionary.open(sldd);
else
    dobj = Simulink.data.dictionary.create(sldd);
end
sobj = getSection(dobj,'Design Data');

p = Simulink.Parameter();
p.CoderInfo.StorageClass = 'Custom';
p.CoderInfo.CustomStorageClass = 'Const';
for i = 1 : length(addvar)
    name = addvar{i};
    value = eval(name);
    p.DataType = 'auto';
    p.Value = value;
    p.DataType = class(value);
    assignin(sobj, name, p);
end
% 保存字典
saveChanges(dobj);
close(dobj);


cd(oldpath);


