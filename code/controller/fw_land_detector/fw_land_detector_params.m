%{
* Fixedwing max horizontal velocity
*
* Maximum horizontal velocity allowed in the landed state
*
* @unit m/s
* @min 0.5
* @max 10
* @decimal 1
*
* @group Land Detector
%}
PARAM_DEFINE_FLOAT('LNDFW_VEL_XY_MAX', 5.0);

%{
* Fixedwing max climb rate
*
* Maximum vertical velocity allowed in the landed state
*
* @unit m/s
* @min 0.1
* @max 20
* @decimal 1
*
* @group Land Detector
%}
PARAM_DEFINE_FLOAT('LNDFW_VEL_Z_MAX', 3.0);

%{
* Fixedwing max horizontal acceleration
*
* Maximum horizontal (x,y body axes) acceleration allowed in the landed state
*
* @unit m/s^2
* @min 2
* @max 15
* @decimal 1
*
* @group Land Detector
%}
PARAM_DEFINE_FLOAT('LNDFW_XYACC_MAX', 8.0);

%{
* Airspeed max
*
* Maximum airspeed allowed in the landed state
*
* @unit m/s
* @min 4
* @max 20
* @decimal 1
*
* @group Land Detector
%}
PARAM_DEFINE_FLOAT('LNDFW_AIRSPD_MAX', 6.00);

