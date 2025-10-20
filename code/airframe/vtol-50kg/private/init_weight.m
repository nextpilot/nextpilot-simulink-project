function mass = init_weight()
% 参考重心
mass.ref_center = [0 0 0.0];

% 空机重量kg
mass.empty_mass = 38;
mass.empty_cog  = [0 0 0.0];

% 质量惯性矩
% 天晴[6.542 12.742 7.105]

% 注意惯性张量是一个对称矩阵，除了对角线都有负号
% I = [
%     Ixx, -Ixy, -Ixz
%     -Iyx, Iyy, -Iyz
%     -Izx, -Izy, Izz
%     ]

% 短机翼
% mass.empty_inertia = [
% 10.122 -0.0023  -0.727
% -0.0023  10.215  -0.0033
% -0.727   -0.0033   19.0
% ];

%%长机翼
mass.empty_inertia = [
    24.344   -0.0067   -0.818
    -0.0067   11.203   -0.0013
    -0.818   -0.0013    34.126
    ];

%% 可调参数和拉偏参数
mass_cog_offset  = PARAM_DEFINE_TUNE(0);
mass_mass_offset = PARAM_DEFINE_TUNE(0);

%% 保存到mat文件
if ~exist("vtol50kg_airframe_data.mat", "file")
    save vtol50kg_airframe_data.mat mass*
else
    save vtol50kg_airframe_data.mat mass* -append
end
