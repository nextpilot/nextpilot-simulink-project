[toc]

# MAV_TYPE参数

该参数表示了机型，含义如下：

```c
/**
 * MAVLink airframe type
 *
 * @min 1
 * @max 27
 * @value 0 Generic micro air vehicle
 * @value 1 Fixed wing aircraft
 * @value 2 Quadrotor
 * @value 3 Coaxial helicopter
 * @value 4 Normal helicopter with tail rotor
 * @value 5 Ground installation
 * @value 6 Operator control unit / ground control station
 * @value 7 Airship, controlled
 * @value 8 Free balloon, uncontrolled
 * @value 9 Rocket
 * @value 10 Ground rover
 * @value 11 Surface vessel, boat, ship
 * @value 12 Submarine
 * @value 13 Hexarotor
 * @value 14 Octorotor
 * @value 15 Tricopter
 * @value 16 Flapping wing
 * @value 17 Kite
 * @value 18 Onboard companion controller
 * @value 19 Two-rotor VTOL using control surfaces in vertical operation in addition. Tailsitter.
 * @value 20 Quad-rotor VTOL using a V-shaped quad config in vertical operation. Tailsitter.
 * @value 21 Tiltrotor VTOL
 * @value 22 VTOL reserved 2
 * @value 23 VTOL reserved 3
 * @value 24 VTOL reserved 4
 * @value 25 VTOL reserved 5
 * @value 26 Onboard gimbal
 * @value 27 Onboard ADSB peripheral
 * @group MAVLink
 */
```

# CBRK参数

| 参数            | 数据类型 | 含义                                                         |
| --------------- | -------- | :----------------------------------------------------------- |
| CBRK_SUPPLY_CHK | int32    | value: 0           使能电源有效性检查<br />value: 894281 禁用电源的有效性检查 |
| CBRK_USB_CHK    | int32    | value: 0            使能USB检查<br />value: 197848 禁止USB检查 |
| CBRK_AIRSPD_CHK | int32    | value: 0           使能空速计检查<br />value: 162128 禁止空速计检查 |
| CBRK_ENGINEFAIL | int32    | value: 0            使能发动机失控检查<br />value: 284953 禁止发动机失控检查 |
| CBRK_FLIGHTTERM | int32    | value: 0            允许FailureDetector或FMU lost的情况下，执行飞行终结程序<br />value: 121212 禁止飞行终结动作 |
| CBRK_VELPOSERR  | int32    | value: 0            允许进行速度和位置精度的检查<br />value: 201607 禁止检查速度和位置精度 |
| CBRK_VTOLARMING | int32    | value: 0            禁止在垂起机型在固定翼模式下解锁<br />value: 159753 允许在垂起机型在固定翼模式下解锁 |

# 解锁授权方法

| 参数             | 数据类型 | 含义                                                         |
| ---------------- | -------- | :----------------------------------------------------------- |
| COM_ARM_AUTH_MET | int32    | value: 0 收到授权时请求授权和解锁<br />value: 1 首先，请求解锁命令；然后，解锁无人机 |
|                  |          |                                                              |

































