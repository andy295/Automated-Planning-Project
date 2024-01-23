#!/bin/bash

# source ROS2 setup.bash
source /opt/ros/humble/setup.bash

# function to remove directory if it exists
remove_directory() {
    if [ -d "$1" ]; then
        echo "Removing $1"
        rm -rf "$1"
    else
        echo "$1 does not exist, skipping removal."
    fi
}

# remove build, log, and install directories
remove_directory "./build"
remove_directory "./log"
remove_directory "./install"

# install ROS2 dependencies
rosdep install --from-paths ./ --ignore-src -r -y

# build using colcon with symlink install
colcon build --symlink-install

# source the setup.bash of the installed workspace
source install/setup.bash

# launch the specified ROS2 launch file
ros2 launch plansys2 problem_5_launch.py
