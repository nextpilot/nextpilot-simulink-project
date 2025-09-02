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
import_param_from_mfile('nextpilot_define_constant.m', sldd);


cd(oldpath);


