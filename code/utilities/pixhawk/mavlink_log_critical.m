function mavlink_log_critical(pub, formatspec, varargin)

if coder.target('MATLAB')
    % 在 MATLAB 中运行（不生成代码）
elseif coder.target('MEX')
    % 生成 MEX 函数
elseif coder.target('Sfun')
    % 仿真 Simulink模型。也用于在加速模式下运行。
    tmp = sprintf(formatspec, varargin{:});
    fprintf(1, '[%.3g]%s\n', getSimulationTime(), tmp);
elseif coder.target('Rtw')
    % 生成 LIB、DLL 或 EXE 目标。也用于在 Simulink Coder 和快速加速模式下运行
    tmp = sprintf(formatspec, varargin{:});
    fprintf(1, '[%.3g]%s\n', getSimulationTime(), tmp);
elseif coder.target('C') || coder.target('C++')
    % 生成C/C++代码
    coder.cinclue('mavlink_log.h');
    coder.ceval('mavlink_log_critical', pub, formatspec);
end