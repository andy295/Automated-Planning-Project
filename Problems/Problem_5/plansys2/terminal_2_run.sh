#!/bin/bash

# rource ROS2 setup.bash
source /opt/ros/humble/setup.bash

# rource the setup.bash of the installed workspace
source install/setup.bash

# run the plansys2_terminal using ROS2 run
ros2 run plansys2_terminal plansys2_terminal
