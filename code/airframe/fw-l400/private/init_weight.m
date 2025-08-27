% 参考重心，构型系
db.mass.ref_cog = [2.308,0,-0.065];

% 空机重量kg
db.mass.empty_weight = 388.499;

% 空机重心，构型系
db.mass.empty_cog = [2166.217, 4.412,-63.91]*1e-3;

% 空机转动惯量（参考重心），对称矩阵，除了对角线都有负号
% I = [
%     Ixx, -Ixy, -Ixz
%     -Iyx, Iyy, -Iyz
%     -Izx, -Izy, Izz
%     ]
db.mass.full_inertia = [
    947.46           -0     -(-78.628)
    -0          1247.13            -0
    -(-78.628)       -0       1994.49
    ];
% db.mass.empty_inertia = [
%     923.60           -0    -(-78.628)
%     -0          1153.78           -0
%     -(-78.628)       -0       1899.36
%     ];

% 空机转动惯量，相对参考重心，后右上坐标系
Ixx = 1066.962;
Iyy = 874.503;
Izz = 1767.8;
Ixy = 0.781;
Ixz = -150.416;
Iyz = 0.413;
I = [
     Ixx, -Ixy, -Ixz
    -Ixy,  Iyy, -Iyz
    -Ixz, -Iyz,  Izz
    ];
% 将
% db.mass.empty_inertia = [
%     923.60           -0    -(-78.628)
%     -0          1153.78           -0
%     -(-78.628)       -0       1899.36
%     ];
