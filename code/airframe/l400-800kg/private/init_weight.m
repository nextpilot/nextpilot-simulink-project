function mass = init_weight()
% 参考重心，构型系
mass.ref_cog = [2308, 0, -65]*1e-3;

% 空机重量kg
mass.empty_weight = 388.499;

% 空机重心，构型系
mass.empty_cog = [2166.217, 0,-63.91]*1e-3;

% 满载重心，构型系
mass.full_cog = [2284.702,0,-221.544]*1e-3;

% 空机转动惯量（原点为空机重心，后右上坐标系）
%
% 转动惯量是对称矩阵，除了对角线都有负号
% catia计算的Ixy等已经添加了负号
%
% I = [
%     Ixx, -Ixy, -Ixz
%     -Iyx, Iyy, -Iyz
%     -Izx, -Izy, Izz
%     ]
%
[Ixx, Iyy, Izz, Ixy, Ixz, Iyz] = deal(1066.954,866.693,1759.983,0.538,-150.476,0.414);
mass.empty_inertia = [
    Ixx, Ixy, Ixz
    Ixy, Iyy, Iyz
    Ixz, Iyz, Izz
    ];
