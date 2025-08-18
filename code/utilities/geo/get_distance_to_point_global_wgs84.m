function [dist, dist_xy, dist_z] = get_distance_to_point_global_wgs84(lat_now, lon_now, alt_now, lat_next, lon_next, alt_next)

CONSTANTS_RADIUS_OF_EARTH = 6371000;
current_x_rad = deg2rad(lat_next);
current_y_rad = deg2rad(lon_next);
x_rad = deg2rad(lat_now);
y_rad = deg2rad(lon_now);

d_lat = x_rad - current_x_rad;
d_lon = y_rad - current_y_rad;

a = sin(d_lat / 2.0) * sin(d_lat / 2.0) + sin(d_lon / 2.0) * sin(d_lon / 2.0) * cos(current_x_rad) * cos(x_rad);
c = 2 * atan2(sqrt(a), sqrt(1 - a));

dxy = (CONSTANTS_RADIUS_OF_EARTH * c);
dz = (alt_now - alt_next);

dist_xy = abs(dxy);
dist_z = abs(dz);
dist =  sqrt(dxy * dxy + dz * dz);