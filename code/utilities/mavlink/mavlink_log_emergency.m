function mavlink_log_emergency(pub, text, varargin)

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
    coder.ceval('mavlink_log_emergency',pub, text);
end