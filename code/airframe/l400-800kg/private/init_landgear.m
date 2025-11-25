function landgear = init_landgear()
% 静摩擦系数
landgear.kstatic = 0.4;
% 滑动摩擦系数
landgear.kdynamic = 0.4/1.2;
% 滚动摩擦系数
landgear.krolling = 0.002;

% 弹簧系数
landgear.kspring = 1e5;
% 阻尼系数
landgear.kdamping = 1e3;



% 左起落架，构型系
landgear.left_pos = [2.2317-0.51,-0.9,0.045-0.9];
% 左起落架，轮胎半径
landgear.left_rad = 0.426/2;


% 右起落架，构型系
landgear.right_pos = [2.2317-0.51,0.9,0.045-0.9];
% 右起落架，轮胎半径
landgear.right_rad = 0.426/2;


% 后起落架，构型系
% landgear.rear_pos = [2.2317+3.75,0,0.045-0.943];
landgear.rear_pos = [2.2317+3.75,0,0.045-0.9];
% 后起落架，轮胎半径
landgear.rear_rad = 0.426/2;
