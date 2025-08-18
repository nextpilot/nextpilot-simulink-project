function dt=hrt_elapsed_time(t)
if coder.target('MATLAB')
    % matlab
    dt= uint64(0);
elseif coder.target('MEX')
    % mexfun
    dt= uint64(0);
elseif coder.target('Sfun')
    % simulink
    dt = uint64(getSimulationTime()*1e6 - t);
elseif coder.target('Rtw')
    % codegen
    dt = uint64(getSimulationTime()*1e6 - t);
elseif coder.target('Custom')
    coder.cinclude('hrt.h');
    dt = coder.ceval('hrt_elapsed_time');
end
