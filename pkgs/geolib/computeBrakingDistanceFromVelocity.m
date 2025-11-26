function dist = computeBrakingDistanceFromVelocity(velocity, jerk, accel,accel_delay_max)

dist = velocity * (velocity / (2.0 * accel) + accel_delay_max / jerk);

