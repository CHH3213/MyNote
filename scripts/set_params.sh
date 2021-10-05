#!/bin/bash
gnome-terminal --tab  --title="set_actuator_rc_ctrl_params" -x bash -c "
rosrun mavros mavparam set SERVO1_FUNCTION 1;
rosrun mavros mavparam set SERVO2_FUNCTION 1;
rosrun mavros mavparam set SERVO3_FUNCTION 1;
rosrun mavros mavparam set SERVO4_FUNCTION 1;
rosrun mavros mavparam set RCMAP_ROLL 5;
rosrun mavros mavparam set RCMAP_PITCH 6;
rosrun mavros mavparam set RCMAP_THROTTLE 7;
rosrun mavros mavparam set RCMAP_YAW 8;
exec bash;"
