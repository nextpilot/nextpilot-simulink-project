function flag = dm_init()

% DM_KEY_SAFE_POINTS = 0;		% Safe points coordinates, safe point 0 is home point
% DM_KEY_FENCE_POINTS = 1;		% Fence vertex coordinates
% DM_KEY_WAYPOINTS_OFFBOARD_0 = 2;	% Mission way point coordinates sent over mavlink
% DM_KEY_WAYPOINTS_OFFBOARD_1 = 3;	% (alternate between 0 and 1)
% DM_KEY_WAYPOINTS_ONBOARD = 4;	% Mission way point coordinates generated onboard
% DM_KEY_MISSION_STATE = 5;		% Persistent mission state
% DM_KEY_COMPAT = 6;
% DM_KEY_NUM_KEYS = 7;			% Total number of item types defined


global dataman
persistent g_dm_inited

if isempty(g_dm_inited)
    if exist('dataman.mat', 'file')
        if ismember('dataman', who('-file', 'dataman.mat', 'dataman'))
            load dataman.mat dataman
        else
            dataman = create_dataman_file();
        end
    else
        dataman = create_dataman_file();
    end
    g_dm_inited = true;

end

flag = g_dm_inited;

function dataman = create_dataman_file()
mission_item.lat                   = 0;
mission_item.lon                   = 0;
mission_item.time_inside           = single(0);
mission_item.circle_radius         = single(0);
mission_item.acceptance_radius     = single(0);
mission_item.loiter_radius         = single(0);
mission_item.yaw                   = single(0);
mission_item.altitude              = single(0);
mission_item.nav_cmd               = uint16(0);
mission_item.do_jump_mission_index = int16(0);
mission_item.do_jump_repeat_count  = uint16(0);
mission_item.do_jump_current_count = uint16(0);
mission_item.vertex_count          = uint16(0);
mission_item.frame                 = uint16(0);
mission_item.origin                = uint16(0);
mission_item.loiter_exit_xtrack    = false;
mission_item.force_heading         = false;
mission_item.altitude_is_relative  = false;
mission_item.autocontinue          = false;
mission_item.vtol_back_transition  = false;

mission_entry.timestamp      = uint64(0);
mission_entry.num_items      = uint16(0);
mission_entry.update_counter = uint16(0);

% 航线执行状态
dataman.mission_state.timestamp   = uint64(0);
dataman.mission_state.dataman_id  = uint8(0);
dataman.mission_state.count       = uint16(0);
dataman.mission_state.current_seq = int32(0);

% 上传航线0
dataman.waypoints_offboard_0.entry = mission_entry;
dataman.waypoints_offboard_0.items(1:1000) = mission_item;
% 上传航线1
dataman.waypoints_offboard_1.entry = mission_entry;
dataman.waypoints_offboard_1.items(1:1000) = mission_item;
% 机载生成航线
dataman.waypoints_onboard.entry = mission_entry;
dataman.waypoints_onboard.items(1:1000) = mission_item;

% 地理围栏
dataman.geofense.entry = mission_entry;
dataman.geofense.items(1:1000) = struct(...
    'lat',                 0, 'lon',                  0, 'alt', single(0), ...
    'vertex_count', uint16(0), 'circle_radius', single(0), ...
    'nav_cmd',      uint16(0), 'frame',         uint8(0));

% 安全着陆点
dataman.safepoint.entry       = mission_entry;
dataman.safepoint.items(1:1000) = struct('lat', 0, 'lon', 0, 'alt', single(0), 'frame', uint8(0));

save dataman.mat  dataman