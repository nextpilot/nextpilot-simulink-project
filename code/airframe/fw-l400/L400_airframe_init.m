
%% 气动数据库
init_aerody;

%% 推力数据库
init_engine;

%% 质量数据库
init_weight;

%% 载荷数据库
init_payload;

%% 电池数据库
init_battery;

%% 起落架数据
init_landgear;

%% 初始状态
db.init.vx_vy_vz=[0 0 0];
db.init.p_q_r = [0 0 0];
db.init.phi_theta_psi = [0 0 0];
db.init.lat_lon_alt = [30 120 0];

