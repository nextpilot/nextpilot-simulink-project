function [test_point_lat, test_point_lon] = waypointFromBearingAndDistance(current_pos_lat,current_pos_lon,test_point_bearing,test_point_distance,earth_radius)

if test_point_distance < 0
    test_point_distance = - test_point_distance;
    test_point_bearing  = wrap_2pi(test_point_bearing + pi);
end

[test_point_lat, test_point_lon] = waypoint_from_heading_and_distance(current_pos_lat, current_pos_lon, test_point_bearing, test_point_distance, earth_radius);

end
