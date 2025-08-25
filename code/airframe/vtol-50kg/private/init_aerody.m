function aerody = init_aerody()

cwd = fileparts([mfilename('fullpath'),'.m']);
mat = fullfile(cwd, '../database/aerody/aerody.mat');
if ~exist(mat, "file")
    addpath(fullfile(cwd, '../database/aerody'))
    process_aerody_data()
end

load(mat, 'aerody');

aerody.chord = 0.361; %飞机弦长
aerody.span = 4.7;  %飞机展长
aerody.wing_aera = 1.61;%机翼面积
