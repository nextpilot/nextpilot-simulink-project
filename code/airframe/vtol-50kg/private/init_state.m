function init_state()
%% 舰船的状态
% 是否舰船上起降
IS_BOAT_TAKEOFF_LAND  = PARAM_DEFINE_TUNE(true);
% 船的姿态角，单位rad
BOAT_PHI_THETA_PSI = PARAM_DEFINE_TUNE([0 0 0]);
% 船的前右下速度，单位m/s
BOAT_U_V_W      = PARAM_DEFINE_TUNE([0 0 0]);

%% 物理环境
% 风速，北东地坐标系，单位m/s
ENVIRON_WINDSPEED = PARAM_DEFINE_TUNE([0 0 0]);

% 地形高度，单位m
ENVIRON_HGROUND   = PARAM_DEFINE_TUNE(0.0);


%% 初始状态
% 初始速度，体轴系，单位m/s
INIT_U_V_W = PARAM_DEFINE_TUNE([0 0 0]);
% 初始角速率，体轴系，单位rad/s
INIT_P_Q_R = PARAM_DEFINE_TUNE([0 0 0]);
% 初始姿态角，单位rad
INIT_PHI_THETA_PSI = PARAM_DEFINE_TUNE([0 0 0]);
% 初始经纬高，单位deg，m
INIT_LAT_LON_ALT = PARAM_DEFINE_TUNE([30 120 ENVIRON_HGROUND.Value]);

%% 保存到mat文件
if ~exist("vtol50kg_airframe_data.mat", "file")
    save vtol50kg_airframe_data.mat
else
    save vtol50kg_airframe_data.mat -append
end