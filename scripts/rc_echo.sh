#!/bin/bash
gnome-terminal --tab  --title="rc-in-echo" -x bash -c "rostopic echo /mavros/rc/in;exec bash;"
gnome-terminal --tab  --title="rc-out-echo" -x bash -c "rostopic echo /mavros/rc/out;exec bash;"
