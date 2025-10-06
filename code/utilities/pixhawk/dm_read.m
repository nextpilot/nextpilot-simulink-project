function [bytes, item] = dm_read(type, index)

arguments
    type   (1, 1) uint8  {mustBeNonnegative} = 0
    index  (1, 1) uint16 {mustBeNonnegative} = 0
end

global dataman

if isempty(dataman)
    dm_init();
end

DM_KEY_SAFE_POINTS = 0;		% Safe points coordinates, safe point 0 is home point
DM_KEY_FENCE_POINTS = 1;		% Fence vertex coordinates
DM_KEY_WAYPOINTS_OFFBOARD_0 = 2;	% Mission way point coordinates sent over mavlink
DM_KEY_WAYPOINTS_OFFBOARD_1 = 3;	% (alternate between 0 and 1)
DM_KEY_WAYPOINTS_ONBOARD = 4;	% Mission way point coordinates generated onboard
DM_KEY_MISSION_STATE = 5;		% Persistent mission state
% DM_KEY_COMPAT = 6;
% DM_KEY_NUM_KEYS = 7;			% Total number of item types defined

item  = struct();
bytes = 0;

switch type
    case DM_KEY_SAFE_POINTS
        if index == 0
            item = dataman.safepoint.entry;
            bytes = 1;
        elseif dataman.safepoint.entry.num_items >= index
            item  = dataman.safepoint.items(index);
            bytes = 1;
        end
    case DM_KEY_FENCE_POINTS
        if index == 0
            item = dataman.geofense.entry;
            bytes = 1;
        elseif dataman.geofense.entry.num_items >= index
            item  = dataman.geofense.items(index);
            bytes = 1;
        end
    case DM_KEY_WAYPOINTS_OFFBOARD_0
        if index == 0
            item  = dataman.waypoints_offboard_0.entry;
            bytes = 1;
        elseif dataman.waypoints_offboard_0.entry.num_items >= index
            item  = dataman.waypoints_offboard_0.items(index);
            bytes = 1;
        end
    case DM_KEY_WAYPOINTS_OFFBOARD_1
        if index == 0
            item  = dataman.waypoints_offboard_1.entry;
            bytes = 1;
        elseif dataman.waypoints_offboard_1.entry.num_items >= index
            item  = dataman.waypoints_offboard_1.items(index);
            bytes = 1;
        end
    case DM_KEY_WAYPOINTS_ONBOARD
        if index == 0
            item  = dataman.waypoints_onboard.entry;
            bytes = 1;
        elseif dataman.waypoints_onboard.entry.num_items >= index
            item  = dataman.waypoints_onboard.items(index);
            bytes = 1;
        end
    case DM_KEY_MISSION_STATE
        item  = dataman.mission_state;
        bytes = 1;
    otherwise
end