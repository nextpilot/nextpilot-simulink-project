function t = hrt_absolute_time_q()

if coder.target('Rtw')
    t = hrt_absolute_time();
else
    t = uint64(getSimulationTime * 1e+6);
end

end

