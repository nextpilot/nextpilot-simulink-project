oldpath = pwd;
newpath = fileparts(mfilename("fullpath") + ".m");

% L400
cd(fullfile(newpath, 'fw-l400'));
L400_airframe_init();

% VTOL-50kg
cd(fullfile(newpath, 'vtol-50kg'));
% L400_airframe_init();

cd(oldpath);
clear oldpath newpath

