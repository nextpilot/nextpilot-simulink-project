function import_datadict()

oldpath = pwd;
newpath = fileparts(mfilename("fullpath") + ".m");
cd(newpath);

% 导入uorb消息
import_uorb_message('uorb/v1.12.3/*.msg', 'L400_datadict.sldd');

% 导入mavlink消息
import_mavlink_message('mavlink/v1.0/common.xml','L400_datadict.sldd');

% 导入param参数
import_param_from_json('param/parameters-v1.12.3.json', 'L400_datadict.sldd');
import_param_from_mfile(fullfile(newpath, '../controller/*_params.m'), 'L400_datadict.sldd')

cd(oldpath);