# 航点类型
uint16 nav_cmd
# 航点来源
uint8 origin

double lat
double lon

# 高度控制
bool altitude_is_relative
float alt

# 航向控制
bool  force_heading
float yaw

# 悬停时间
float time_inside
float loiter_radius

# 接受半径
float acceptance_radius

# 是否继续
bool autocontinue

# 航点跳转
int16 do_jump_mission_index
uint16 do_jump_repeat_count

bool vtol_back_transition
