function vtol50kg_airframe_init()

nosave_oldpath = pwd;
cd(fileparts(mfilename('fullpath')));

%% 发动机
engine = init_engine;

%% 旋翼动力
motor = init_motor;

%% 气动数据
aerody = init_aerody;

%% 质量数据
mass = init_weight;

%% 载荷数据
payload = init_payload;



%% 初始状态
% 初始速度，体轴系，单位m/s
nosave_init.u_v_w = [0 0 0];
% 初始角速率，体轴系，单位rad/s
nosave_init.p_q_r = [0 0 0];
% 初始姿态角，但是rad
nosave_init.phi_theta_psi = [0 0 0];
% 初始经纬高，单位deg，m
nosave_init.lat_lon_alt = [30 120 0];
init = Simulink.Parameter(nosave_init);

%% 物理环境
environ.wind.const_wind = [0 0 0];
environ.terrain.hground = 0;

% ^(?!nosave_).+ 表示不以 nosave_ 开头的变量
save vtol50kg_airframe_data.mat -regexp ^(?!nosave_).+

cd(nosave_oldpath);