function landgear = init_landgear()
% 左起落架，构型系
landgear.left_pos = [2.2317-0.51,-0.9,0.045-0.9];
% 左起落架，轮胎半径
landgear.left_rad = 0.426/2;

% 右起落架，构型系
landgear.right_pos = [2.2317-0.51,0.9,0.045-0.9];
% 右起落架，轮胎半径
landgear.right_rad = 0.426/2;


% 后起落架，构型系
landgear.rear_pos = [2.2317+3.75,0,0.045-0.943];
% 后起落架，轮胎半径
landgear.rear_rad = 0.426/2;
% 后起落架，前倾角
landgear.rear_forerake = 0;
% 