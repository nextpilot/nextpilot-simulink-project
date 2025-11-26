function mavlink_and_console_log_info(pub, formatspec, varargin)


if coder.target('MATLAB')
    % matlab
elseif coder.target('MEX')
    % mexfun
elseif coder.target('Sfun')
    % simulink
     tmp = sprintf(formatspec, varargin{:});
    fprintf(1, '[%.3g]%s\n', getSimulationTime(), tmp);
elseif coder.target('Rtw')
    % codegen
     tmp = sprintf(formatspec, varargin{:});
    fprintf(1, '[%.3g]%s\n', getSimulationTime(), tmp);
elseif coder.target('C') || coder.target('C++')
    % C/C++
    coder.cinclue('mavlink_log.h');
    coder.ceval('mavlink_and_console_log_info',pub, text);
end