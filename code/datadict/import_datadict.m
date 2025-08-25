function import_datadict()

oldpath = pwd;
newpath = fileparts(mfilename("fullpath") + ".m");
cd(newpath);

% 导入uorb消息
import_uorb_from_msg('uorb/v1.12.3/*.msg', 'nextpilot_datadict.sldd');

% 导入mavlink消息
import_mavlink_from_xml('mavlink/v1.0/common.xml','nextpilot_datadict.sldd');

% 导入param参数
import_param_from_json('param/parameters-v1.12.3.json', 'nextpilot_datadict.sldd');

cd(oldpath);