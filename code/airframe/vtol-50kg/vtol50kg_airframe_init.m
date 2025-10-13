function vtol50kg_airframe_init()

nosave_oldpath = pwd;
cd(fileparts(mfilename('fullpath')));

%% 读取数据
% 发动机
engine = init_engine;
engine_thrust_scale = create_global_parameter(1.0);
% 旋翼动力
motor  = init_motor;
motor_thrust_scale = create_global_parameter(0.85);    
% 气动数据
aerody = init_aerody;
aerody_drag_scale = create_global_parameter(1/0.6);
% 质量数据
mass   = init_weight;
% 载荷数据
payload = init_payload;


%% 物理环境
% 风速，北东地坐标系，单位m/s
windspeed = create_global_parameter([0 0 0]);
% 地形高度，单位m
hground   = create_global_parameter(0.0);


%% 初始状态
% 初始速度，体轴系，单位m/s
init_u_v_w = create_global_parameter([0 0 0]);
% 初始角速率，体轴系，单位rad/s
init_p_q_r = create_global_parameter([0 0 0]);
% 初始姿态角，但是rad
init_phi_theta_psi = create_global_parameter([0 0 0]);
% 初始经纬高，单位deg，m
init_lat_lon_alt = create_global_parameter([30 120 hground.Value]);

%% 保存数据
% ^(?!nosave_).+ 表示不以 nosave_ 开头的变量
save vtol50kg_airframe_data.mat -regexp ^(?!nosave_).+

cd(nosave_oldpath);


function param = create_global_parameter(value)

param = Simulink.Parameter(value);
param.CoderInfo.StorageClass = 'Custom';
% param.CoderInfo.CustomStorageClass = 'GetSet';