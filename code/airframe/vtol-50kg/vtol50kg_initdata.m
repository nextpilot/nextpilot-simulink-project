
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
init.lat_lon_alt   = [30. 120. 0];
init.vx_vy_vz      = [1263 0 0];
init.ax_ay_az      = [0 89522 0];
init.phi_theta_psi = [0 0 0];
init.p_q_r         = [0 0 0];
init = Simulink.Parameter(init);

% 风速