function distance = get_distance_to_next_waypoint(lat_now, lon_now, lat_next, lon_next)

CONSTANTS_RADIUS_OF_EARTH = 6371000;

lat_now_rad = deg2rad(lat_now);
lat_next_rad = deg2rad(lat_next);

d_lat = lat_next_rad - lat_now_rad;
d_lon = deg2rad(lon_next) - deg2rad(lon_now);

a = sin(d_lat / 2.0) * sin(d_lat / 2.0) + sin(d_lon / 2.0) * sin(d_lon / 2.0) * cos(lat_now_rad) * cos(lat_next_rad);

c = atan2(sqrt(a), sqrt(1.0 - a));

distance = single(CONSTANTS_RADIUS_OF_EARTH * 2.0 * c);
