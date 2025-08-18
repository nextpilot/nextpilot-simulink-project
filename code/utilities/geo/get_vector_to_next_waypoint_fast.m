function [v_n, v_e] = get_vector_to_next_waypoint_fast(lat_now, lon_now, lat_next, lon_next)

CONSTANTS_RADIUS_OF_EARTH = 6371000;

lat_now_rad = deg2rad(lat_now);
lon_now_rad = deg2rad(lon_now);

lat_next_rad = deg2rad(lat_next);
lon_next_rad = deg2rad(lon_next);

d_lat = lat_next_rad - lat_now_rad;
d_lon = lon_next_rad - lon_now_rad;

v_n = (CONSTANTS_RADIUS_OF_EARTH * d_lat);
v_e = (CONSTANTS_RADIUS_OF_EARTH * d_lon * cos(lat_now_rad));