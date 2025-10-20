function vtol50kg_airframe_init()

%% 切换目录
oldpath = pwd;
cd(fileparts(mfilename('fullpath')));

%% 飞机本体
% 发动机
init_engine;
% 旋翼动力
init_motor;
% 气动数据
init_aerody;
% 质量数据
init_weight;
% 载荷数据
init_payload;

%% 初始状态
init_state;

%% 恢复目录
cd(oldpath);


