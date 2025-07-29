oldpath = pwd;

cd(fileparts(mfilename("fullpath") + ".m"));

% 导入uorb消息
import_uorb_message('uorb/v1.12.3/*.msg', 'L400_datadict.sldd');

% 导入mavlink消息
import_mavlink_message('mavlink/v1.0/common.xml','L400_datadict.sldd');

cd(oldpath);