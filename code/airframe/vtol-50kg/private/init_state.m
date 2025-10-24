function init_state()
%% 舰船的状态
% 是否舰船上起降
boat_takeoff_land  = PARAM_DEFINE_TUNE(true);
% 船的姿态角，单位rad
boat_phi_theta_psi = PARAM_DEFINE_TUNE([0 0 0]);
% 船的前右下速度，单位m/s
boat_u_v_w      = PARAM_DEFINE_TUNE([0 0 0]);

%% 物理环境
% 风速，北东地坐标系，单位m/s
environ_windspeed = PARAM_DEFINE_TUNE([0 0 0]);

% 地形高度，单位m
environ_hground   = PARAM_DEFINE_TUNE(0.0);


%% 初始状态
% 初始速度，体轴系，单位m/s
init_u_v_w = PARAM_DEFINE_TUNE([0 0 0]);
% 初始角速率，体轴系，单位rad/s
init_p_q_r = PARAM_DEFINE_TUNE([0 0 0]);
% 初始姿态角，单位rad
init_phi_theta_psi = PARAM_DEFINE_TUNE([0 0 0]);
% 初始经纬高，单位deg，m
init_lat_lon_alt = PARAM_DEFINE_TUNE([30 120 environ_hground.Value]);

%% 保存到mat文件
if ~exist("vtol50kg_airframe_data.mat", "file")
    save vtol50kg_airframe_data.mat
else
    save vtol50kg_airframe_data.mat -append
end