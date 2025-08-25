%% 搜索模型 - example_linearization 的指定工作点


%% 指定模型名称
model = 'example_linearization';

%% 创建工作点设定对象。
opspec = operspec(model);

%% 设置对模型中状态的约束
% - 所有状态的默认值为: Known = false，SteadyState = true，
% Min = -Inf，Max = Inf，dxMin = -Inf 和 dxMax = Inf。

% 状态(1) - example_linearization/Model|example_sdofplant/6DOF (Quaternion)/Calculate DCM & Euler Angles/q0 q1 q2 q3
% - 默认模型初始条件用于初始化优化。
% opspec.States(1).x = angle2quat(0,-1*pi/180, 0, 'ZYX');
% opspec.States(1).Known = [false;false;false;false]; % 一般航向已知
% opspec.States(1).SteadyState = [true;true;true;true];

opspec.States(1).x = [0 0 0];
opspec.States(1).Known = [false;false;false]; % 一般航向已知
opspec.States(1).SteadyState = [true;true;true];

% 状态(2) - example_linearization/Model|example_sdofplant/6DOF (Quaternion)/p,q,r
% - 默认模型初始条件用于初始化优化。
opspec.States(2).x = [0;0;0];
opspec.States(2).Known = [false;false;false];
opspec.States(2).SteadyState = [true;true;true];

% 状态(3) - example_linearization/Model|example_sdofplant/6DOF (Quaternion)/ub,vb,wb
opspec.States(3).x = [28;0;0];
opspec.States(3).Known = [false;false;false];
opspec.States(3).SteadyState = [true;true;true];

% 状态(4) - example_linearization/Model|example_sdofplant/6DOF (Quaternion)/xe,ye,ze
% - 默认模型初始条件用于初始化优化。
opspec.States(4).x = [0;0;0];
opspec.States(4).Known = [false;false;true];
opspec.States(4).SteadyState = [false;false;true];

% 状态(5) - example_linearization/Model|example_sdofplant/actuator/engine/Integrator
% - 默认模型初始条件用于初始化优化。
% opspec.States(5).SteadyState = false;

%% 设置对模型中输入的约束
% - 所有输入的默认值为: Known = false，Min = -Inf 和
% Max = Inf。

% 输入(1) - example_linearization/mc_rf
% - 默认模型初始条件用于初始化优化。
opspec.Inputs(1).Known = true;

% 输入(2) - example_linearization/mc_lb
% - 默认模型初始条件用于初始化优化。
opspec.Inputs(2).Known = true;

% 输入(3) - example_linearization/mc_lf
% - 默认模型初始条件用于初始化优化。
opspec.Inputs(3).Known = true;

% 输入(4) - example_linearization/mc_rb
% - 默认模型初始条件用于初始化优化。
opspec.Inputs(4).Known = true;

% 输入(5) - example_linearization/fw_da
% - 默认模型初始条件用于初始化优化。
opspec.Inputs(5).Known = false;
opspec.Inputs(5).Min = -1;
opspec.Inputs(5).Max = 1;

% 输入(6) - example_linearization/fw_dlr
% - 默认模型初始条件用于初始化优化。
opspec.Inputs(6).Known = false;
opspec.Inputs(6).Min = -1;
opspec.Inputs(6).Max = 1;

% 输入(7) - example_linearization/fw_drr
% - 默认模型初始条件用于初始化优化。
opspec.Inputs(7).Known = false;
opspec.Inputs(7).Min = -1;
opspec.Inputs(7).Max = 1;

% 输入(8) - example_linearization/fw_throttle
% - 默认模型初始条件用于初始化优化。
opspec.Inputs(8).u = 0.2;
opspec.Inputs(8).Known = false;
opspec.Inputs(8).Min = 0;
opspec.Inputs(8).Max = 1;


%% 创建选项
opt = findopOptions('OptimizerType','simplex','DisplayReport','iter');
opt.OptimizationOptions.MaxFunEvals = 200000;
opt.OptimizationOptions.MaxIter = 2000;
opt.OptimizationOptions.TolFun = 1.000000e-06;
opt.OptimizationOptions.TolX = 1.000000e-06;
opt.OptimizationOptions.Algorithm = 'active-set';
opt.OptimizationOptions.DiffMaxChange = Inf;
opt.OptimizationOptions.DiffMinChange = 0;
opt.OptimizationOptions.Jacobian = 'off';
opt.OptimizationOptions.TolCon = 1.000000e-06;

%% 执行工作点搜索
[op,opreport] = findop(model,opspec,opt);
