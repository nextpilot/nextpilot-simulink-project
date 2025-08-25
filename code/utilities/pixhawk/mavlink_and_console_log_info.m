function mavlink_and_console_log_info(pub, text, varargin)


if coder.target('MATLAB')
    % matlab
elseif coder.target('MEX')
    % mexfun
elseif coder.target('Sfun')
    % simulink
    fprintf('[%.3g]%s\n', getSimulationTime(), text);
elseif coder.target('Rtw')
    % codegen
    fprintf('[%.3g]%s\n', getSimulationTime(), text);
elseif coder.target('Custom')
    %
    coder.cinclue('mavlink_log.h');
    coder.ceval('mavlink_and_console_log_info',pub, text);
end