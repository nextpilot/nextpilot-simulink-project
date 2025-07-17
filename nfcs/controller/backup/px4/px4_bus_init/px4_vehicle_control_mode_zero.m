%% ------------------------------------------------------------------
%  You can modify the values of the fields in px4_vehicle_control_mode_MATLABStruct
%  and evaluate this cell to create/update this structure
%  in the MATLAB base workspace.
% -------------------------------------------------------------------
function ret = px4_vehicle_control_mode_zero()

ret = struct;
ret.timestamp = uint64(0);
ret.flag_armed = false;
ret.flag_external_manual_override_ok = false;
ret.flag_multicopter_position_control_enabled = false;
ret.flag_control_manual_enabled = false;
ret.flag_control_auto_enabled = false;
ret.flag_control_offboard_enabled = false;
ret.flag_control_rates_enabled = false;
ret.flag_control_attitude_enabled = false;
ret.flag_control_acceleration_enabled = false;
ret.flag_control_velocity_enabled = false;
ret.flag_control_position_enabled = false;
ret.flag_control_altitude_enabled = false;
ret.flag_control_climb_rate_enabled = false;
ret.flag_control_termination_enabled = false;

end


