function [lat_res, lon_res] = add_vector_to_global_position(lat_now, lon_now, v_n, v_e)

CONSTANTS_RADIUS_OF_EARTH = 6371000;

lat_now_rad = deg2rad(lat_now);
lon_now_rad = deg2rad(lon_now);


lat_res= rad2deg(lat_now_rad + v_n / CONSTANTS_RADIUS_OF_EARTH);
lon_res = rad2deg(lon_now_rad + v_e / (CONSTANTS_RADIUS_OF_EARTH * cos(lat_now_rad)));