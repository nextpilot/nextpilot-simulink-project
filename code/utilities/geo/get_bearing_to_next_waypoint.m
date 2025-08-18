function bearing = get_bearing_to_next_waypoint(lat_now, lon_now, lat_next, lon_next)
lat_now_rad = deg2rad(lat_now);
lat_next_rad = deg2rad(lat_next);

cos_lat_next = cos(lat_next_rad);
d_lon = deg2rad(lon_next - lon_now);

% conscious mix of double and float trig function to maximize speed and efficiency
y = (sin(d_lon) * cos_lat_next);
x = (cos(lat_now_rad) * sin(lat_next_rad) - sin(lat_now_rad) * cos_lat_next * cos(d_lon));

bearing = atan2(y, x);