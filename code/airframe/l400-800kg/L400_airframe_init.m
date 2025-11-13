function L400_airframe_init()

nosave_oldpath = pwd;
cd(fileparts(mfilename('fullpath')));

%% 气动数据库
[db.aerody, db.dds, db.hingle] = init_aerody;

%% 推力数据库
db.motor = init_engine;

%% 质量数据库
db.mass = init_weight;

%% 载荷数据库
db.payload = init_payload;

%% 电池数据库
db.battery = init_battery;

%% 起落架数据
db.landgear = init_landgear;

%% 物理环境
ENVIRON_WINDSPEED = PARAM_DEFINE_TUNE([0 0 0]);
ENVIRON_HGROUND = PARAM_DEFINE_TUNE(0);

%% 初始状态
% 初始速度，体轴系，单位m/s
INIT_U_V_W = PARAM_DEFINE_TUNE([0 0 0]);
% 初始角速率，体轴系，单位rad/s
INIT_P_Q_R = PARAM_DEFINE_TUNE([0 0 0]);
% 初始姿态角，但是rad
INIT_PHI_THETA_PSI = PARAM_DEFINE_TUNE([0 0 0]);
% 初始经纬高，单位deg，m
INIT_LAT_LON_ALT = PARAM_DEFINE_TUNE([30 120 ENVIRON_HGROUND.Value]);


save L400_airframe_data.mat db INIT* ENVIRON*

cd(nosave_oldpath);