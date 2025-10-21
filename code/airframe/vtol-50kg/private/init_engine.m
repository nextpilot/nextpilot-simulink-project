function engine = init_engine()


% 发动机安装位置
engine.setup_position  = [0,0,0];
% 发动机安装角（ZYX顺序），psi=0，theta=1，phi=0
engine.setup_angle = [0, 3, 0]*pi/180;
% 发动机旋转方向（从尾部看，顺时针为正）
engine.setup_rotation  = +1;


% 推力桨直径  单位英寸
engine.propeller_dia = 22;
% 桨叶数目
engine.blade_count = 2;

% 发动机拉力曲线
eng_perf1 = [
    %节气门开度   转速rpm		推力（N）
    0          0      0
    10/100     0      0
    12/100    3400   55
    17/100    4000   69.1
    19/100    4270   76
    21/100    4550   82.2
    25/100    4800   89.5
    31/100    5070   99.3
    32/100    5250   105.8
    33/100    5450   112.3
    34/100    5700   123.5
    41/100    6000   139
    45/100    6250   152.5
    67/100    6530   163.9
    72/100    7000   170
    80/100    7250   174.2
    ];
engine.thrust.delta = eng_perf1(:,1);
engine.thrust.rpm = eng_perf1(:,2);
engine.thrust.force = eng_perf1(:,3);

% 发动机扭矩曲线
eng_perf2 = [
    % 节气门开度%	功率（kW）	扭矩(N*m)	转速(rpm)	燃油消耗率kg/（kW·h）
    0       0       0       0       0
    20/100	0.69	1.57	4200	0.525
    30/100	1.92	3.31	5550	0.392
    40/100	2.45	3.65	6400	0.382
    50/100	3.23	4.47	6900	0.350
    60/100	3.63	4.85	7150	0.386
    70/100	3.74	4.92	7250	0.369
    80/100	3.78	4.92	7330	0.372
    90/100	3.84	4.92	7350	0.378
    100/100	3.84	4.99	7350	0.383
    ];
engine.torque.delta  = eng_perf2(:,1);
engine.torque.power  = eng_perf2(:,2);
engine.torque.moment = eng_perf2(:,3);
engine.torque.rpm    = eng_perf2(:,4);
engine.torque.fuel_cons_rate = eng_perf2(:,5);


%% 可调参数和拉偏参数
%初始燃油重量
engine_init_fuel    = PARAM_DEFINE_TUNE(7);
engine_thrust_scale = PARAM_DEFINE_TUNE(0.8);
engine_torque_scale = PARAM_DEFINE_TUNE(1.0);


%% 保存到mat文件
if ~exist("vtol50kg_airframe_data.mat", "file")
    save vtol50kg_airframe_data.mat engine*
else
    save vtol50kg_airframe_data.mat engine* -append
end
