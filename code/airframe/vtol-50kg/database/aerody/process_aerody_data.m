clc
clear

cwd = fileparts([mfilename('fullpath'),'.m']);

%% 基础构型
[force, moment] = read_basic_coeff(fullfile(cwd, 'basic'));
% 力
temp = sortrows(force(1:end-1, :), [2, 1]);
alpha = unique(temp.alpha);
beta = unique(temp.beta);
field = {'cx', 'cy', 'cz'};
for i = 1 : 3
    aerody.basic.(field{i}).alpha = alpha;
    aerody.basic.(field{i}).beta = beta;
    aerody.basic.(field{i}).coeff =  reshape(temp.(field{i}), length(alpha), length(beta));
end

% 力矩
temp = sortrows(moment(1:end-1, :), [2, 1]);
alpha = unique(temp.alpha);
beta = unique(temp.beta);
field = {'cll', 'cm', 'cn'};
for i = 1 : 3
    aerody.basic.(field{i}).alpha = alpha;
    aerody.basic.(field{i}).beta = beta;
    aerody.basic.(field{i}).coeff =  reshape(temp.(field{i}), length(alpha), length(beta));
end


%% 起落架
[force, moment] = read_basic_coeff(fullfile(cwd, 'landgear'));
config = 'landgear';
% 力
temp = sortrows(force, [2 1]);
alpha = unique(temp.alpha);
beta = unique(temp.beta);
field = {'cx', 'cy', 'cz'};
for j = 1 : 3
    % 基础构型系数
    coeff_basic = interpn(aerody.basic.(field{j}).alpha, aerody.basic.(field{j}).beta, aerody.basic.(field{j}).coeff, alpha, beta');
    % 当前构型
    aerody.(config).(field{j}).alpha = alpha;
    aerody.(config).(field{j}).beta = beta;
    aerody.(config).(field{j}).coeff =  reshape(temp.(field{j}), length(alpha), length(beta));
    % 减去基本构型
    aerody.(config).(field{j}).coeff = aerody.(config).(field{j}).coeff - coeff_basic;
end

% 力矩
temp = sortrows(moment, [2, 1]);
alpha = unique(temp.alpha);
beta = unique(temp.beta);
field = {'cll', 'cm', 'cn'};
for j = 1 : 3
    % 基础构型系数
    coeff_basic = interpn(aerody.basic.(field{j}).alpha, aerody.basic.(field{j}).beta, aerody.basic.(field{j}).coeff, alpha, beta');
    % 当前构型
    aerody.(config).(field{j}).alpha = alpha;
    aerody.(config).(field{j}).beta = beta;
    aerody.(config).(field{j}).coeff =  reshape(temp.(field{j}), length(alpha), length(beta));
    % 减去基本构型
    aerody.(config).(field{j}).coeff = aerody.(config).(field{j}).coeff - coeff_basic;
end

%% 舵面气动
folder = {'left-aileron', 'right-aileron', 'left-rudder', 'right-rudder'};
for i = 1 : length(folder)
    config = strrep(folder{i},'-','_');
    [force, moment] = read_surface_coeff(fullfile(cwd, folder{i}));

    % 力
    temp = sortrows(force, [3, 2, 1]);
    alpha = unique(temp.alpha);
    beta = unique(temp.beta);
    delta = unique(temp.delta);
    field = {'cx', 'cy', 'cz'};

    for j = 1 : 3
        % 基础构型系数
        coeff_basic = interpn(aerody.basic.(field{j}).alpha, aerody.basic.(field{j}).beta, aerody.basic.(field{j}).coeff, alpha, beta');
        % 当前构型
        aerody.(config).(field{j}).alpha = alpha;
        aerody.(config).(field{j}).beta = beta;
        aerody.(config).(field{j}).delta = delta;
        aerody.(config).(field{j}).coeff =  reshape(temp.(field{j}), length(alpha), length(beta), length(delta));
        % 减去基本构型
        for k = 1 : length(delta)
            aerody.(config).(field{j}).coeff(:,:,k) = aerody.(config).(field{j}).coeff(:,:,k) - coeff_basic;
        end
    end

    % 力矩
    temp = sortrows(moment, [3, 2, 1]);
    alpha = unique(temp.alpha);
    beta = unique(temp.beta);
    delta = unique(temp.delta);
    field = {'cll', 'cm', 'cn'};
    for j = 1 : 3
        % 基础构型系数
        coeff_basic = interpn(aerody.basic.(field{j}).alpha, aerody.basic.(field{j}).beta, aerody.basic.(field{j}).coeff, alpha, beta');
        % 当前构型
        aerody.(config).(field{j}).alpha = alpha;
        aerody.(config).(field{j}).beta = beta;
        aerody.(config).(field{j}).delta = delta;
        aerody.(config).(field{j}).coeff =  reshape(temp.(field{j}), length(alpha), length(beta), length(delta));
        % 减去基本构型
        for k = 1 : length(delta)
            aerody.(config).(field{j}).coeff(:,:,k) = aerody.(config).(field{j}).coeff(:,:,k) - coeff_basic;
        end
    end
end

%%
% 添加beta=0的数据
% 1. 为左副翼添加beta=0数据
if ~ismember(0, aerody.left_aileron.cx.beta)
    % 获取右副翼beta=0的数据
    ra_beta0_idx = find(aerody.right_aileron.cx.beta == 0, 1);
    
    % 为左副翼添加beta=0
    aerody.left_aileron.cx.beta = [0; aerody.left_aileron.cx.beta];
    aerody.left_aileron.cy.beta = [0; aerody.left_aileron.cy.beta];
    aerody.left_aileron.cz.beta = [0; aerody.left_aileron.cz.beta];
    aerody.left_aileron.cll.beta = [0; aerody.left_aileron.cll.beta];
    aerody.left_aileron.cm.beta = [0; aerody.left_aileron.cm.beta];
    aerody.left_aileron.cn.beta = [0; aerody.left_aileron.cn.beta];
    
    % 在beta维度添加新切片
    % cx, cz, cm 与右副翼相同
    aerody.left_aileron.cx.coeff = cat(2, aerody.right_aileron.cx.coeff(:,ra_beta0_idx,:), aerody.left_aileron.cx.coeff);
    aerody.left_aileron.cz.coeff = cat(2, aerody.right_aileron.cz.coeff(:,ra_beta0_idx,:), aerody.left_aileron.cz.coeff);
    aerody.left_aileron.cm.coeff = cat(2, aerody.right_aileron.cm.coeff(:,ra_beta0_idx,:), aerody.left_aileron.cm.coeff);
    
    % cy, cll, cn 取反
    aerody.left_aileron.cy.coeff = cat(2, -aerody.right_aileron.cy.coeff(:,ra_beta0_idx,:), aerody.left_aileron.cy.coeff);
    aerody.left_aileron.cll.coeff = cat(2, -aerody.right_aileron.cll.coeff(:,ra_beta0_idx,:), aerody.left_aileron.cll.coeff);
    aerody.left_aileron.cn.coeff = cat(2, -aerody.right_aileron.cn.coeff(:,ra_beta0_idx,:), aerody.left_aileron.cn.coeff);
    
    disp('已为左副翼添加 beta=0 数据');
end

% 2. 为左方向舵添加beta=0数据
if ~ismember(0, aerody.left_rudder.cx.beta)
    % 获取右方向舵beta=0的数据
    rr_beta0_idx = find(aerody.right_rudder.cx.beta == 0, 1);
    
    % 为左方向舵添加beta=0
    aerody.left_rudder.cx.beta = [0; aerody.left_rudder.cx.beta];
    aerody.left_rudder.cy.beta = [0; aerody.left_rudder.cy.beta];
    aerody.left_rudder.cz.beta = [0; aerody.left_rudder.cz.beta];
    aerody.left_rudder.cll.beta = [0; aerody.left_rudder.cll.beta];
    aerody.left_rudder.cm.beta = [0; aerody.left_rudder.cm.beta];
    aerody.left_rudder.cn.beta = [0; aerody.left_rudder.cn.beta];
    
    % 在beta维度添加新切片
    % cx, cz, cm 与右方向舵相同
    aerody.left_rudder.cx.coeff = cat(2, aerody.right_rudder.cx.coeff(:,rr_beta0_idx,:), aerody.left_rudder.cx.coeff);
    aerody.left_rudder.cz.coeff = cat(2, aerody.right_rudder.cz.coeff(:,rr_beta0_idx,:), aerody.left_rudder.cz.coeff);
    aerody.left_rudder.cm.coeff = cat(2, aerody.right_rudder.cm.coeff(:,rr_beta0_idx,:), aerody.left_rudder.cm.coeff);
    
    % cy, cll, cn 取反
    aerody.left_rudder.cy.coeff = cat(2, -aerody.right_rudder.cy.coeff(:,rr_beta0_idx,:), aerody.left_rudder.cy.coeff);
    aerody.left_rudder.cll.coeff = cat(2, -aerody.right_rudder.cll.coeff(:,rr_beta0_idx,:), aerody.left_rudder.cll.coeff);
    aerody.left_rudder.cn.coeff = cat(2, -aerody.right_rudder.cn.coeff(:,rr_beta0_idx,:), aerody.left_rudder.cn.coeff);
    
    disp('已为左方向舵添加 beta=0 数据');
end


%% 添加负beta数据
% 定义需要处理的构型列表
configs = {'basic', 'landgear', 'left_aileron', 'right_aileron', 'left_rudder', 'right_rudder'};
% 定义需要处理的系数列表
coeff_fields = {'cx', 'cy', 'cz', 'cll', 'cm', 'cn'};
% 定义正负beta映射关系
beta_pairs = [4, -4; 8, -8; 12, -12];

for cidx = 1:length(configs)
    config = configs{cidx};
    for fidx = 1:length(coeff_fields)
        field = coeff_fields{fidx};
        
        % 获取当前系数结构
        coeff_struct = aerody.(config).(field);
        current_beta = coeff_struct.beta;
        
        % 检查并添加每个负beta
        for pair = beta_pairs'
            beta_pos = pair(1);
            beta_neg = pair(2);
            
            % 如果负beta不存在且正beta存在
            if ~ismember(beta_neg, current_beta) && ismember(beta_pos, current_beta)
                % 获取正beta的索引
                pos_idx = find(current_beta == beta_pos, 1);
                
                % 根据系数类型确定数据生成规则
                if ismember(field, {'cx', 'cz', 'cll', 'cm'})
                    % 对称系数：直接复制
                    new_data = coeff_struct.coeff(:, pos_idx, :);
                else
                    % 反对称系数：取负数
                    new_data = -coeff_struct.coeff(:, pos_idx, :);
                end
                
                % 添加新beta数据
                current_beta = [current_beta; beta_neg];
                
                % 根据维度处理数据拼接
                if ndims(coeff_struct.coeff) == 2  % 基础构型和起落架
                    coeff_struct.coeff = [coeff_struct.coeff, new_data];
                else  % 舵面构型
                    coeff_struct.coeff = cat(2, coeff_struct.coeff, new_data);
                end
                
                fprintf('已为 %s 构型的 %s 添加 beta=%d 数据\n', config, field, beta_neg);
            end
        end
        
        % 按beta排序数据
        [sorted_beta, sort_idx] = sort(current_beta);
        if ndims(coeff_struct.coeff) == 2
            sorted_coeff = coeff_struct.coeff(:, sort_idx);
        else
            sorted_coeff = coeff_struct.coeff(:, sort_idx, :);
        end
        
        % 更新结构体
        aerody.(config).(field).beta = sorted_beta;
        aerody.(config).(field).coeff = sorted_coeff;
    end
end
%% 保存数据

%% 将数据从气流坐标系转换到体轴系
% 定义所有构型列表
configs = {'basic', 'landgear', 'left_aileron', 'right_aileron', 'left_rudder', 'right_rudder'};

% 遍历所有构型
for cidx = 1:length(configs)
    config = configs{cidx};
    fprintf('正在转换构型: %s\n', config);
    
    % 为舵面构型添加delta=0数据点并确保降序排列
    if ismember(config, {'left_aileron', 'right_aileron', 'left_rudder', 'right_rudder'})
        % 确保delta按降序排列
        [sorted_delta, sort_idx] = sort(aerody.(config).cx.delta, 'descend');
        
        % 重新排序所有系数矩阵
        fields = {'cx', 'cy', 'cz', 'cll', 'cm', 'cn'};
        for j = 1:length(fields)
            field = fields{j};
            coeff = aerody.(config).(field).coeff;
            aerody.(config).(field).delta = sorted_delta;
            aerody.(config).(field).coeff = coeff(:, :, sort_idx);
        end
        
        % 添加delta=0点（如果缺失）
        if ~ismember(0, sorted_delta)
            fprintf('为 %s 构型添加 delta=0 数据点\n', config);
            
            % 添加delta=0到delta向量
            new_delta = [sorted_delta; 0];
            [sorted_delta, sort_idx] = sort(new_delta, 'ascend');
            
            % 在系数矩阵中添加delta=0切片（全为0）
            for j = 1:length(fields)
                field = fields{j};
                coeff = aerody.(config).(field).coeff;
                zero_slice = zeros(size(coeff, 1), size(coeff, 2));
                new_coeff = cat(3, coeff, zero_slice);
                
                % 更新系数矩阵并按delta降序排列
                aerody.(config).(field).coeff = new_coeff(:, :, sort_idx);
                aerody.(config).(field).delta = sorted_delta;
            end
        end
    end
    
    % 处理力系数
    aerody.(config).cx.coeff = -aerody.(config).cx.coeff;  % X方向力系数取反
    aerody.(config).cz.coeff = -aerody.(config).cz.coeff;  % Z方向力系数取反
    
    % 处理力矩系数
    aerody.(config).cll.coeff = -aerody.(config).cll.coeff;  % 滚转力矩取反
    aerody.(config).cn.coeff = -aerody.(config).cn.coeff;    % 偏航力矩取反
    
    % cy和cm保持不变
end

% 验证舵面构型delta=0点是否为0且delta降序排列
for config = {'left_aileron', 'right_aileron', 'left_rudder', 'right_rudder'}
    config = config{1};
    delta = aerody.(config).cx.delta;
    
    % 验证delta按降序排列
    if ~issorted(delta, 'ascend')
        error('%s 构型 delta 未按升序排列!', config);
    end
    
    if ismember(0, delta)
        zero_idx = find(delta == 0);
        
        % 检查力系数
        max_cx = max(abs(aerody.(config).cx.coeff(:,:,zero_idx)), [], 'all');
        max_cy = max(abs(aerody.(config).cy.coeff(:,:,zero_idx)), [], 'all');
        max_cz = max(abs(aerody.(config).cz.coeff(:,:,zero_idx)), [], 'all');
        
        % 检查力矩系数
        max_cll = max(abs(aerody.(config).cll.coeff(:,:,zero_idx)), [], 'all');
        max_cm = max(abs(aerody.(config).cm.coeff(:,:,zero_idx)), [], 'all');
        max_cn = max(abs(aerody.(config).cn.coeff(:,:,zero_idx)), [], 'all');
        
        if max_cx > 1e-6 || max_cy > 1e-6 || max_cz > 1e-6 || ...
           max_cll > 1e-6 || max_cm > 1e-6 || max_cn > 1e-6
            error('%s 构型 delta=0 点不为零!', config);
        else
            fprintf('%s 构型: delta降序排列, delta=0点验证通过\n', config);
        end
    else
        fprintf('%s 构型: delta降序排列, 但缺少delta=0点\n', config);
    end
end

fprintf('所有气动数据已从气流坐标系转换到体轴系\n');
%% 保存数据

save(fullfile(cwd, 'aerody.mat'), 'aerody');