function dm_save()

global g_dataman_info

matfile = fullfile(fileparts(mfilename('fullpath')), 'dataman.mat');

save(matfile, 'g_dataman_info');