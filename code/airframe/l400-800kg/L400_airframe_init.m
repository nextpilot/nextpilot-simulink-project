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

%% 初始状态
% 初始速度，体轴系，单位m/s
init_u_v_w = [0 0 0];
% 初始角速率，体轴系，单位rad/s
init_p_q_r = [0 0 0];
% 初始姿态角，但是rad
init_phi_theta_psi = [0 0 0];
% 初始经纬高，单位deg，m
init_lat_lon_alt = [30 120 0];

%% 物理环境
environ_windspeed = [0 0 0];
environ_hground = 0;

save L400_airframe_data.mat db init* environ*

cd(nosave_oldpath);