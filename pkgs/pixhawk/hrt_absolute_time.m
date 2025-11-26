function t=hrt_absolute_time()
if coder.target('MATLAB')
    % matlab
    t= uint64(0);
elseif coder.target('MEX')
    % mexfun
    t= uint64(0);
elseif coder.target('Sfun')
    % simulink
    t = uint64(getSimulationTime()*1e6);
elseif coder.target('Rtw')
    % codegen
    t = uint64(getSimulationTime()*1e6);
elseif coder.target('Custom')
    coder.cinclude('hrt.h');
    t = coder.ceval('hrt_absolute_time');
end
