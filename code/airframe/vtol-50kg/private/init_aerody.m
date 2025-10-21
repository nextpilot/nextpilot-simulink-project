function aerody = init_aerody()

cwd = fileparts([mfilename('fullpath'),'.m']);
mat = fullfile(cwd, '../database/aerody/aerody.mat');
if ~exist(mat, "file")
    addpath(fullfile(cwd, '../database/aerody'))
    process_aerody_data()
end

load(mat, 'aerody');

aerody.ref_chord = 0.361; %飞机弦长
aerody.ref_span  = 4.7;  %飞机展长
aerody.ref_aera = 1.61;%机翼面积

aerody.ref_length = [aerody.ref_chord, aerody.ref_chord, aerody.ref_chord];


%% 气动数据拉偏
aerody_force_scale  = PARAM_DEFINE_TUNE([2, 2, 1]);     % 气流系
aerody_moment_scale = PARAM_DEFINE_TUNE([1, 1, 0.5]);     % 体轴系

%% 保存到mat文件
if ~exist("vtol50kg_airframe_data.mat", "file")
    save vtol50kg_airframe_data.mat aerody*
else
    save vtol50kg_airframe_data.mat aerody* -append
end