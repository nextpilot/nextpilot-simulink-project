function [x, y] = map_projection_project(ref, lat, lon)

if (~map_projection_initialized(ref))
    x = NaN;
    y = NaN;
    return ;
end

CONSTANTS_RADIUS_OF_EARTH = single(6371000);

% lat,lon are expected to be in correct format: -> 47.1234567 and not 471234567

lat_rad = deg2rad(lat);
lon_rad = deg2rad(lon);

sin_lat = sin(lat_rad);
cos_lat = cos(lat_rad);

cos_d_lon = cos(lon_rad - ref.lon_rad);

arg = ref.sin_lat * sin_lat + ref.cos_lat * cos_lat * cos_d_lon;

if arg > 1
    arg = 1;
elseif arg < -1
    arg = -1;
end

c = acos(arg);

if abs(c) > 0
    k = c / sin(c);
else
    k = 1;
end

x = k * (ref.cos_lat * sin_lat - ref.sin_lat * cos_lat * cos_d_lon) * CONSTANTS_RADIUS_OF_EARTH;
y = k * cos_lat * sin(lon_rad - ref.lon_rad) * CONSTANTS_RADIUS_OF_EARTH;

end

