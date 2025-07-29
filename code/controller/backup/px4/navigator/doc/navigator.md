[toc]

# navigator主函数

## vehicle_command_sub

```flow
start=>start: navigator
subcommand=>operation: 订阅指令(周期50ms)

abort_land=>condition: 中止着陆？
do_abort_land=>operation: 中止着陆

reposition=>condition: 重新定位？
do_reposition=>operation: 重新定位

auto_takeoff=>condition: 自动起飞？
do_auto_takeoff=>operation: 自动起飞

start_land=>condition: 开始着陆？
do_start_land=>operation: 开始着陆

start_mission=>condition: 开始任务？
do_start_mission=>operation: 开始任务

chagnge_speed=>condition: 改变速度？
do_chagnge_speed=>operation: 改变速度

else=>condition: 其他？
do_else=>operation: 其他

end=>end: 返回信息


start->subcommand->abort_land(no)->reposition
abort_land(yes)->do_abort_land

reposition(no)->auto_takeoff
reposition(yes)->do_reposition

auto_takeoff(no)->start_land
auto_takeoff(yes)->do_auto_takeoff

start_land(no)->start_mission
start_land(yes)->do_start_land

start_mission(no)->chagnge_speed
start_mission(yes)->do_start_mission

chagnge_speed(no)->else
chagnge_speed(yes)->do_chagnge_speed

else(yes)->do_else


```

### 中止着陆

仅做应答处理。

### 重新定位

​			**GF_SOURCE**：地理围栏选择应该使用的位置源； 0：融合数据，1：GPS数据；

1. 先检查收到的目标点是否在地理围栏内，返回有效性标志位**reposition_valid**；

```c++
_geofence.check(test_reposition_validity, _gps_pos, _home_pos, home_position_valid())
```

2. 如果**reposition_valid**有效，将当前位置（local_pos）存储为position_setpoint_triplet中的previos，并且检查需要更改位置的哪些信息（纬度、经度、高度、航向等）；否则，发送mavlink通知地面站；**多旋翼替换当前位置的时候加上了刹车距离那一段；**

```c++
if (_vstatus.vehicle_type == vehicle_status_s::VEHICLE_TYPE_ROTARY_WING
    && (get_position_setpoint_triplet()->current.type != position_setpoint_s::SETPOINT_TYPE_TAKEOFF)) {

    // 对于多旋翼无人机会考虑刹车距离，否侧会过冲
    double lat, lon;
    // 计算地面航向
    float course_over_ground = atan2f(_local_pos.vy, _local_pos.vx);

    // 计算水平方向的速度
    const float velocity_hor_abs = sqrtf(_local_pos.vx * _local_pos.vx + _local_pos.vy * _local_pos.vy);

    // 预测刹车距离
    float multirotor_braking_distance = math::trajectory::computeBrakingDistanceFromVelocity(velocity_hor_abs, _param_mpc_jerk_auto, _param_mpc_acc_hor, 0.6f * _param_mpc_jerk_auto);

    waypoint_from_heading_and_distance(get_global_position()->lat, get_global_position()->lon, course_over_ground, multirotor_braking_distance, &lat, &lon);
    rep->current.lat = lat;
    rep->current.lon = lon;
    rep->current.yaw = get_local_position()->heading;
    rep->current.yaw_valid = true;

} else {
    // 对于固定翼，将当前位置作为loiter点
    rep->current.lat = get_global_position()->lat;
    rep->current.lon = get_global_position()->lon;
}
```

## NavigatorMode

```c++
void NavigatorMode::run(bool active)
{
    if (active) {
        if (!_active) {
            /* first run, reset stay in failsafe flag */
            // 模式刚刚处于激活的状态，这里运行一次， pos_sp_triplet必须在这里初始化
            _navigator->get_mission_result()->stay_in_failsafe = false;
            _navigator->set_mission_result_updated();
            on_activation();
        } else {
            /* periodic updates when active */
            // 模式激活以后，以一定的频率执行
            on_active();
        }

    } else {
        /* periodic updates when inactive */
        // 模式上次激活，这次没有激活
        if (_active) {
            on_inactivation();
        } else {
            // 模式上次没激活，这次也没有激活
            on_inactive();
        }
    }

    _active = active;
}
```

## check_mission_valid

​		**函数功能**：检查任务是否准备就绪

```c++
void Mission::check_mission_valid(bool force)
{
    // home点初始化成功并且有效
	if ((!_home_inited && _navigator->home_position_valid()) || force) {
	
		MissionFeasibilityChecker _missionFeasibilityChecker(_navigator);

		_navigator->get_mission_result()->valid =
			_missionFeasibilityChecker.checkMissionFeasible(_mission,
					_param_mis_dist_1wp.get(),
					_param_mis_dist_wps.get(),
					_navigator->mission_landing_required());

		_navigator->get_mission_result()->seq_total = _mission.count;
		_navigator->increment_mission_instance_count();
		_navigator->set_mission_result_updated();
		_home_inited = _navigator->home_position_valid();

		// find and store landing start marker (if available)
		find_mission_land_start();
	}
}
```

### checkMissionFeasible

​			**函数功能**：

		1.  检查home点的有效性
		1.  检查第一个有效的航点与home点的距离是否大于预设的阈值MIS_DIST_1WP（默认：900m）

```c++
bool MissionFeasibilityChecker::checkMissionFeasible(const mission_s &mission,
		float max_distance_to_1st_waypoint, float max_distance_between_waypoints,
		bool land_start_req)
{
	// Reset warning flag
	_navigator->get_mission_result()->warning = false;

	// trivial case: A mission with length zero cannot be valid
    // mission的索引值为负数，航点无效
	if ((int)mission.count <= 0) {
		return false;
	}

	bool failed = false;

	// first check if we have a valid position
    // 检查home点是否有效
	const bool home_valid = _navigator->home_position_valid();
	const bool home_alt_valid = _navigator->home_alt_valid();

	if (!home_alt_valid) {
		failed = true;
		mavlink_log_info(_navigator->get_mavlink_log_pub(), "Not yet ready for mission, no position lock.");

	} else {
		failed = failed || !checkDistanceToFirstWaypoint(mission, max_distance_to_1st_waypoint);
	}

	const float home_alt = _navigator->get_home_position()->alt;

	// check if all mission item commands are supported
    // 检查是否支持所有任务项命令
    
    // 检查命令是否有效
	failed = failed || !checkMissionItemValidity(mission);
    
    // 检查航点间的距离
	failed = failed || !checkDistancesBetweenWaypoints(mission, max_distance_between_waypoints);
    
    // 检查所有的mission点是否都在地理围栏以内
	failed = failed || !checkGeofence(mission, home_alt, home_valid);
    
    // 检查所有的航点是否全部都在home点的高度以上
	failed = failed || !checkHomePositionAltitude(mission, home_alt, home_alt_valid);

	if (_navigator->get_vstatus()->is_vtol) {
		failed = failed || !checkVTOL(mission, home_alt, false);

	} else if (_navigator->get_vstatus()->vehicle_type == vehicle_status_s::VEHICLE_TYPE_ROTARY_WING) {
		failed = failed || !checkRotarywing(mission, home_alt);

	} else {
		failed = failed || !checkFixedwing(mission, home_alt, land_start_req);
	}

	return !failed;
}
```

#### checkDistanceToFirstWaypoint

​		**函数功能**：检查第一个有效的航点与home点的距离是否大于预设的阈值MIS_DIST_1WP（默认：900m），大于该值，该航点有效性为false。

```c++
bool MissionFeasibilityChecker::checkDistanceToFirstWaypoint(const mission_s &mission, float max_distance)
{
    // max_distance等于MIS_DIST_1WP（默认：900m）
    // 故障安全检查，以防止在新的起飞地点运行先前飞行存储的任务。
	// 设置0或更小的值禁用。如果当前位置与waypoint比MIS_DIS_1WP距离home位置更远，任务将不会开始，
	if (max_distance <= 0.0f) {
		/* param not set, check is ok */
		return true;
	}

	/* find first waypoint (with lat/lon) item in datamanager */
	for (size_t i = 0; i < mission.count; i++) {

		struct mission_item_s mission_item {};
		
        // 读取的数据长度不对，通知地面站报错，返回mission无效
		if (!(dm_read((dm_item_t)mission.dataman_id, i, &mission_item, sizeof(mission_item_s)) == sizeof(mission_item_s))) {
			/* error reading, mission is invalid */
			mavlink_log_info(_navigator->get_mavlink_log_pub(), "Error reading offboard mission.");
			return false;
		}

		/* check only items with valid lat/lon */
        // 检查经纬度的有效性，有效的话就执行下去；无效的话，判断下个mission点
		if (!MissionBlock::item_contains_position(mission_item)) {
			continue;
		}

		/* check distance from current position to item */
        // 判断第一个航点与home点的距离是否大于max_distance：MIS_DIST_1WP（默认：900m）
        // 如果小于参数MIS_DIST_1WP，直接返回true，表示该航点可用
        // 否则，通知地面站距离太远
		float dist_to_1wp = get_distance_to_next_waypoint(
					    mission_item.lat, mission_item.lon,
					    _navigator->get_home_position()->lat, _navigator->get_home_position()->lon);

		if (dist_to_1wp < max_distance) {
			return true;

		} else {
			/* item is too far from home */
			mavlink_log_critical(_navigator->get_mavlink_log_pub(),
					     "First waypoint too far away: %dm, %d max",
					     (int)dist_to_1wp, (int)max_distance);

			_navigator->get_mission_result()->warning = true;
			return false;
		}
	}

	/* no waypoints found in mission, then we will not fly far away */
    // 在任务中没有发现航路点，那么我们就不会飞得很远
	return true;
}
```

#### checkDistancesBetweenWaypoints

​		**函数功能**：故障安全检查，防止执行太大的任务。将值设置为零或更小以禁用。如果后续航路点的间距大于MIS_DIST_WPS（默认：900m），任务将不会开始；

```c++
bool MissionFeasibilityChecker::checkDistancesBetweenWaypoints(const mission_s &mission, float max_distance)
{
    // max_distance等于MIS_DIST_WPS
	if (max_distance <= 0.0f) {
		/* param not set, check is ok */
		return true;
	}

	double last_lat = (double)NAN;
	double last_lon = (double)NAN;
	int last_cmd = 0;

	/* Go through all waypoints */
    // 遍历所有航点
	for (size_t i = 0; i < mission.count; i++) {

		struct mission_item_s mission_item {};

		if (!(dm_read((dm_item_t)mission.dataman_id, i, &mission_item, sizeof(mission_item_s)) == sizeof(mission_item_s))) {
			/* error reading, mission is invalid */
			mavlink_log_info(_navigator->get_mavlink_log_pub(), "Error reading offboard mission.");
			return false;
		}

		/* check only items with valid lat/lon */
		if (!MissionBlock::item_contains_position(mission_item)) {
			continue;
		}

		/* Compare it to last waypoint if already available. */
        // 与上一个航点之间的距离；因此，需要上一个航点是有效的
		if (PX4_ISFINITE(last_lat) && PX4_ISFINITE(last_lon)) {

			/* check distance from current position to item */
			const float dist_between_waypoints = get_distance_to_next_waypoint(
					mission_item.lat, mission_item.lon,
					last_lat, last_lon);


			if (dist_between_waypoints > max_distance) {
				/* distance between waypoints is too high */
				mavlink_log_critical(_navigator->get_mavlink_log_pub(),
						     "Distance between waypoints too far: %d meters, %d max.",
						     (int)dist_between_waypoints, (int)max_distance);

				_navigator->get_mission_result()->warning = true;
				return false;

				/* do not allow waypoints that are literally on top of each other */

				/* and do not allow condition gates that are at the same position as a navigation waypoint */

			} else if (dist_between_waypoints < 0.05f &&
				   (mission_item.nav_cmd == NAV_CMD_CONDITION_GATE || last_cmd == NAV_CMD_CONDITION_GATE)) {

				/* Waypoints and gate are at the exact same position, which indicates an
				 * invalid mission and makes calculating the direction from one waypoint
				 * to another impossible. */
				mavlink_log_critical(_navigator->get_mavlink_log_pub(),
						     "Distance between waypoint and gate too close: %d meters",
						     (int)dist_between_waypoints);

				_navigator->get_mission_result()->warning = true;
				return false;
			}
		}

		last_lat = mission_item.lat;
		last_lon = mission_item.lon;
		last_cmd = mission_item.nav_cmd;
	}

	/* We ran through all waypoints and have not found any distances between waypoints that are too far. */
    // 我们遍历了所有的航路点，没有发现任何距离太远的航路点
	return true;
}
```

# prepare_mission_items

```c++
bool Mission::prepare_mission_items(
    struct mission_item_s *mission_item,
	struct mission_item_s *next_position_mission_item, bool *has_next_position_item,
	struct mission_item_s *after_next_position_mission_item, 
    bool *has_after_next_position_item)
{
	*has_next_position_item = false;
	bool first_res = false;
	int offset = 1;

	if (_mission_execution_mode == mission_result_s::MISSION_EXECUTION_MODE_REVERSE) {
		offset = -1;
	}

	if (read_mission_item(0, mission_item)) {

		first_res = true;

		/* trying to find next position mission item */
		while (read_mission_item(offset, next_position_mission_item)) {
			if (_mission_execution_mode == mission_result_s::MISSION_EXECUTION_MODE_REVERSE) {
				offset--;

			} else {
				offset++;
			}

			if (item_contains_position(*next_position_mission_item)) {
				*has_next_position_item = true;
				break;
			}
		}

		if (_mission_execution_mode != mission_result_s::MISSION_EXECUTION_MODE_REVERSE &&
		    after_next_position_mission_item && has_after_next_position_item) {
			/* trying to find next next position mission item */
			while (read_mission_item(offset, after_next_position_mission_item)) {
				offset++;

				if (item_contains_position(*after_next_position_mission_item)) {
					*has_after_next_position_item = true;
					break;
				}
			}
		}
	}

	return first_res;
}
```

