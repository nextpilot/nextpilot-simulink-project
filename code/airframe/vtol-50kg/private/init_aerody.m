
cwd = fileparts([mfilename('fullpath'),'.m']);

load(fullfile(cwd, '../database/aerody/aerody.mat'));


aerody.chord = 0.361; %飞机弦长
aerody.span = 4.7;  %飞机展长
aerody.wing_aera = 1.61;%机翼面积

clear cwd
