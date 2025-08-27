

clc
clear

%%

% % 质量
% M = 388.499;
% % 重心原点
% Og = [2166.217	4.412	-63.91]'*1e-3;
% % 重心惯矩
% Ig = vec2mat([1066.954	866.693	1759.983	0.538	-150.476	0.414]);
% 
% % 参考原点
% Op = [2308	0	-65]'*1e-3;
% Ip = vec2mat([1066.962	874.503	1767.8	0.781	-150.416	0.413])
% Ip_ = move_inertia(Ig, M, Og-Op)
% 
% Ip - Ip_
% return

%% part1
% 质量
M = 1800.000 ;

% 重心坐标
Og = [-1530.000 0, -460.000 ]'*1e-3;
% 重心惯性张量
% Ixx Iyy Izz Ixy  Ixz Iyz
Ig = vec2mat([204 1500 1404 0  0  0 ]);

% 原点坐标
Oo = [0 0 0]'*1e-3;
% 原点惯性张量
Io = vec2mat([584.88 6094.5 5617.62  0 -1266.84  0])
Io_ = move_inertia(Ig, M, -Og)

% 坐标系A
Oa = [-30 300 -960]'*1e-3;
Ia = vec2mat([816 6000 5616 -810 1350 270 ])
Ia_ = move_inertia(Ig, M, -Oa)


%% part2

% 质量
M = 136688.569;

% 重心
Og = [17480.264  ;5667.385   ;300.000 ]*1e-3;
Ig = vec2mat([1e+006 ,7.942e+006 ,8.934e+006 ,-361457.871 ,0 ,0  ])


% 原点
Oo = [0 ;0; 0];
Io = vec2mat([5.403e+006 ,4.972e+007 ,5.509e+007 ,-1.39e+007 ,-716805.663 ,-232400.009   ])
Io_ = move_inertia(Ig, M, Oo-Og)
Io-Io_

Ig_ =move_inertia(Io, M, Og)

% A点
Oa = [16159.388  ;12589.942 ;600   ]*1e-3;
Ia =vec2mat([7.563e+006 ,8.193e+006 ,1.572e+007 ,888400.405 ,54164.594  ,-283870.32    ]);

function I = vec2mat(V)
Ixx = V(1);
Iyy = V(2);
Izz = V(3);
Ixy = V(4); Iyx = Ixy;
Ixz = V(5); Izx = Ixz;
Iyz = V(6); Izy = Iyz;

use_catia = true;

if use_catia 
    % catia在计算惯性积的时候已经添加了负号
    I = [
   Ixx, Ixy, Ixz
   Iyx, Iyy, Iyz
   Izx, Izy, Izz
   ];
else
    % solidworks在计算惯性积的时候没有添加负号
    I = [
   Ixx, -Ixy, -Ixz
   -Iyx, Iyy, -Iyz
   -Izx, -Izy, Izz
   ];
end
end


function Ib = move_inertia(Ia,m,pab)

pab = pab(:);

Ib = Ia + m * (pab'*pab*eye(3) - pab *pab');

end

function Ib = rotate_inertial(Ia, Rab)

Ib = Rab * Ia *Rab';
end