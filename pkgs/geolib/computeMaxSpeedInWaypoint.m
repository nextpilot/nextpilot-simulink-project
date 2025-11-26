function max_speed_in_turn = computeMaxSpeedInWaypoint(alpha, accel, d)

tan_alpha = tan(alpha / 2.0);
max_speed_in_turn = sqrt(accel * d * tan_alpha);

