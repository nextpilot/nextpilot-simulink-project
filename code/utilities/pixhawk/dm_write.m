function [bytes] = dm_write(type, index, item)

arguments
    type   (1, 1) uint8  {mustBeNonnegative} = 0
    index  (1, 1) uint16 {mustBeNonnegative} = 0
    item   (1, 2) struct {} = struct
end

global g_dataman_info

if isempty(g_dataman_info)
    dm_init();
end

DM_ITEM_MAX = 1000;

DM_KEY_SAFE_POINTS = 0;		% Safe points coordinates, safe point 0 is home point
DM_KEY_FENCE_POINTS = 1;		% Fence vertex coordinates
DM_KEY_WAYPOINTS_OFFBOARD_0 = 2;	% Mission way point coordinates sent over mavlink
DM_KEY_WAYPOINTS_OFFBOARD_1 = 3;	% (alternate between 0 and 1)
DM_KEY_WAYPOINTS_ONBOARD = 4;	% Mission way point coordinates generated onboard
DM_KEY_MISSION_STATE = 5;		% Persistent mission state
% DM_KEY_COMPAT = 6;
% DM_KEY_NUM_KEYS = 7;			% Total number of item types defined

bytes = 0;

if isempty(item) || index > DM_ITEM_MAX || DM_ITEM_MAX < 0
    return;
end

switch type
    case DM_KEY_SAFE_POINTS
        if index == 0
            g_dataman_info.safepoint.entry = item;
            bytes = 1;
        elseif index <= DM_ITEM_MAX && index > 0
            g_dataman_info.safepoint.itmes(index) = item;
            bytes = 1;
        end
    case DM_KEY_FENCE_POINTS
        if index == 0
            g_dataman_info.geofense.entry = item;
            bytes = 1;
        elseif index <= DM_ITEM_MAX && index > 0
            g_dataman_info.geofense.itmes(index) = item;
            bytes = 1;
        end
    case DM_KEY_WAYPOINTS_OFFBOARD_0
        if index == 0
            g_dataman_info.waypoints_offboard_0.entry = item;
            bytes = 1;
        elseif index <= DM_ITEM_MAX && index > 0
            g_dataman_info.waypoints_offboard_0.itmes(index) = item;
            bytes = 1;
        end
    case DM_KEY_WAYPOINTS_OFFBOARD_1
        if index == 0
            g_dataman_info.waypoints_offboard_1.entry = item;
            bytes = 1;
        elseif index <= DM_ITEM_MAX && index > 0
            g_dataman_info.waypoints_offboard_1.itmes(index) = item;
            bytes = 1;
        end
    case DM_KEY_WAYPOINTS_ONBOARD
        if index == 0
            g_dataman_info.waypoints_onboard.entry = item;
            bytes = 1;
        elseif index <= DM_ITEM_MAX && index > 0
            g_dataman_info.waypoints_onboard.itmes(index) = item;
            bytes = 1;
        end
    case DM_KEY_MISSION_STATE
        g_dataman_info.mission_state = item;
        bytes = 1;
    otherwise
end
