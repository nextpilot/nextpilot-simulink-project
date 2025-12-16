
% 机器人工具箱和航空工具箱中方向余弦dcm是反的，在进行运算的时候，需要将dcm需要转置之后才会相等
%
% px4中四元数是体到地，方向余弦是地到体
%

ang = [10 20 30] *pi/180;

%% angle to dcm
clc
dcm1 = angle2dcm(ang(1),ang(2),ang(3))
dcm2 = eul2rotm(ang)' - dcm1
dcm3 = ang2dcm(ang, 'zyx') - dcm1
dcm =dcm1;



%% angle to quat
clc
quat1 = angle2quat(ang(1), ang(2), ang(3))
quat2 = eul2quat(ang) - quat1
quat3 = ang2quat(ang, 'zyx') -quat1
quat = quat1;

%% dcm to angle
clc
ang
[a,b,c]= dcm2angle(dcm, 'zyx'); ang1 =[a,b,c]
ang2 = rotm2eul(dcm', 'zyx') - ang
ang3 = dcm2ang(dcm) - ang


%% dcm to quat
clc

quat
quat1 = dcm2quat(dcm)
quat2 = rotm2quat(dcm') - quat
quat3 = dcm2quat2(dcm) - quat


%% quat to angle
clc
dcm
dcm1 = quat2dcm(quat) - dcm
dcm2 = quat2rotm(quat)' - dcm
dcm3 = quat2dcm2(quat) - dcm