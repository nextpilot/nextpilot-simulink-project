% 参考重心（体轴系）
db.mass.COGref = [2.1876, 0 0.1386].*[-1,1,-1];

% 空机重量kg
db.mass.Wempty = 400;

% 空机重心（体轴系统）
db.mass.COGempty = [2.1876, 0 0.1386].*[-1,1,-1];

% 空机转动惯量（参考重心）
% 对称矩阵，除了对角线都有负号
% I = [
%     +Ixx   -Ixy  -Ixz
%     -Iyx   +Iyy  -Iyz
%     -Izx   -Izy  +Izz
%     ]
db.mass.Iempty = eye(3);

% 转动惯量的平移和旋转公式如下
% 坐标1，通过旋转R，然后平移D，到坐标系2
% I'=R*I*R'