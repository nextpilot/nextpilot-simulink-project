function mixer_data_init()

MIXER_TYPE_NULL   = 0;
MIXER_TYPE_MC     = 1;
IMXER_TYPE_SIMPLE = 2;

%% 多旋翼
mc_mixers.type = MIXER_TYPE_MC;
% max rise time (slew rate limit)
mc_mixers.slew_rate = 0; % <=0 表示不限制
% neg_scale, pos_scale, offset, min, max
mc_mixers.output_scale = [1, 1, 0, -1, 1];
% 每一行一个电机，每一列对应roll, pitch, yaw, thrust
mc_mixers.control_scale = [
    -0.7071    0.7071    1.0000    1.0000   1.0000
    0.7071   -0.7071    1.0000    1.0000    1.0000
    0.7071    0.7071   -1.0000    1.0000   1.0000
    -0.7071   -0.7071   -1.0000    1.0000  1.0000
    ];

%% 固定翼
fw_mixers(1).type  = IMXER_TYPE_SIMPLE;
% max rise time (slew rate limit)
fw_mixers(1).slew_rate = 0;
% neg_scale, pos_scale, offset, min, max
fw_mixers(1).output_scale = [1, 1, 0, -1, 1];
% M: 2
% group, index, neg_scale, pos_scale, offset, min, max
% S: 0 0  1 1 0 -1 1
% S: 0 6  1 1 0 -1 1
fw_mixers(1).control_scale =[
    0 0 1 1 0 -1 1
    0 2 1 1 0 -1 1
    0 6 1 1 0 -1 1
    0 6 1 1 0 -1 1
    ];

fw_mixers(2).type  = IMXER_TYPE_SIMPLE;
% max rise time (slew rate limit)
fw_mixers(2).slew_rate = 0;
% neg_scale, pos_scale, offset, min, max
fw_mixers(2).output_scale = [1, 1, 0, -1, 1];
% M: 2
% group, index, neg_scale, pos_scale, offset, min, max
% S: 0 0  1 1 0 -1 1
% S: 0 6  1 1 0 -1 1
fw_mixers(2).control_scale =[
    0 0 1 1 0 -1 1
    0 2 1 1 0 -1 1
    0 6 1 1 0 -1 1
    0 6 1 1 0 -1 1
    ];

%% 保存到文件
save mixer_data.mat

