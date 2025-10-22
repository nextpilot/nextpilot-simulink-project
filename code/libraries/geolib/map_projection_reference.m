function [ref_lat_rad, ref_lon_rad] = map_projection_reference(ref)
if map_projection_initialized(ref)
    ref_lat_rad = ref.lat_rad;
    ref_lon_rad = ref.lon_rad;
else
    ref_lat_rad = NaN;
    ref_lon_rad = NaN;
end

