clc
clear
close all


cwd = fileparts([mfilename('fullpath'),'.m']);

if ~exist(fullfile(cwd, 'aerody_wind.mat'),'file')
    process_aerody_data();
end

% 加载气流坐标系数据
load('aerody_wind.mat', 'aerody_wind');

% 定义要处理的构型
configs = {'basic', 'left_aileron', 'right_aileron', 'left_rudder', 'right_rudder'};

% 创建结果结构体，保留原始数据
aero_results = aerody_wind; % 复制原始结构体

for cidx = 1:length(configs)
    config = configs{cidx};
    fprintf('处理构型: %s\n', config);
    
    % 获取当前构型的数据
    data = aero_results.(config);
    
    % 获取网格点
    alphas = data.cx.alpha;
    betas = data.cx.beta;
    
    % 如果有舵面偏角，获取delta值
    if isfield(data.cx, 'delta')
        deltas = data.cx.delta;
        has_delta = true;
    else
        deltas = 0; % 无舵面偏角
        has_delta = false;
    end
    
    % 初始化结果数组（与原始数据维度相同）
    if has_delta
        CL = zeros(length(alphas), length(betas), length(deltas));
        CD = zeros(length(alphas), length(betas), length(deltas));
        K = zeros(length(alphas), length(betas), length(deltas)); % 升阻比
    else
        CL = zeros(length(alphas), length(betas));
        CD = zeros(length(alphas), length(betas));
        K = zeros(length(alphas), length(betas)); % 升阻比
    end
    
    % 遍历所有网格点
    for i = 1:length(alphas)
        for j = 1:length(betas)
            for k = 1:length(deltas)
                % 获取当前点的攻角和侧滑角
                alpha = alphas(i);
                beta = betas(j);
                
                % 获取当前点的力系数
                if has_delta
                    cx = data.cx.coeff(i, j, k);
                    cy = data.cy.coeff(i, j, k);
                    cz = data.cz.coeff(i, j, k);
                else
                    cx = data.cx.coeff(i, j);
                    cy = data.cy.coeff(i, j);
                    cz = data.cz.coeff(i, j);
                end
                
                % 创建力系数向量（体轴系）
                cx_cy_cz = [cx; cy; cz];
                
                % 计算方向余弦矩阵（DCM）从体轴系到气流坐标系
                dcm = angle2dcm(-alpha*pi/180, beta*pi/180,  0, 'yzx');
                
                % 将体轴系力系数转换到气流坐标系
                cd_cy_cl = dcm * cx_cy_cz;
                
                % 提取阻力系数和升力系数
                cd = cd_cy_cl(1);
                cl = cd_cy_cl(3);
                
                % 计算升阻比（避免除以零）
                if abs(cd) > 1e-6
                    k_ratio = cl / cd;
                else
                    k_ratio = sign(cl) * Inf;
                end
                
                % 存储结果
                if has_delta
                    CL(i, j, k) = cl;
                    CD(i, j, k) = cd;
                    K(i, j, k) = k_ratio;
                else
                    CL(i, j) = cl;
                    CD(i, j) = cd;
                    K(i, j) = k_ratio;
                end
            end
        end
    end
    
    % 将计算结果添加到原始数据结构中
    data.CL = struct();
    data.CL.alpha = alphas;
    data.CL.beta = betas;
    data.CL.coeff = CL;
    
    data.CD = struct();
    data.CD.alpha = alphas;
    data.CD.beta = betas;
    data.CD.coeff = CD;
    
    data.K = struct();
    data.K.alpha = alphas;
    data.K.beta = betas;
    data.K.coeff = K;
    
    % 如果是舵面构型，添加delta字段
    if has_delta
        data.CL.delta = deltas;
        data.CD.delta = deltas;
        data.K.delta = deltas;
    end
    
    % 更新结果结构体
    aero_results.(config) = data;
    
    fprintf('完成构型: %s\n', config);
end

% 保存完整的计算结果（包含原始数据和计算结果）
save('aerody_wind_results.mat', 'aero_results');
fprintf('计算结果已保存到 aerody_wind_with_results.mat\n');

subplot(311)
hold on
grid on
for i = 1:length(aerody.basic.cll.beta)
    plot(aerody.basic.cll.alpha, aerody.basic.cll.coeff(:, i))
end

%%