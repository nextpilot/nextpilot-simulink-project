function mass = init_weight()
% 参考重心
mass.ref_center = [0 0 0.05];

% 空机重量kg
mass.empty_weight = 38;

% 质量惯性矩
% 天晴[6.542 12.742 7.105]

% 短机翼
% mass.emtpy_inertia = [
% 10.122 0.0023  0.727
% 0.0023  10.215  0.0033
% 0.727   0.0033   19.0
% ];
%%长机翼
mass.emtpy_inertia = [
    24.344  0.0067   0.818
    0.0067  11.203   0.0013
    0.818   0.0013   34.126
    ];
