# Problem 5

## Commands
To run the problem, two terminals are needed.

### Terminal 1
Open the first terminal and run the following commands:

```bash
# from any location
source /opt/ros/humble/setup.bash

# move to the workspace
cd ~/<path>/Problem_5/plansys2

# prepare the workspace
rosdep install --from-paths ./ --ignore-src -r -y
colcon build --symlink-install

# source the workspace
source install/setup.bash

# launch the problem
ros2 launch plansys2 problem_5_launch.py
```

### Terminal 2
Open the second terminal and run the following commands:

```bash
# from any location
source /opt/ros/humble/setup.bash

# move to the workspace
cd ~/<path>/Problem_5/plansys2

# prepare the workspace
source install/setup.bash

# launch the problem
ros2 run plansys2_terminal plansys2_terminal

# once ros2 is running, run the following commands

# ros2 commands
source pddl/problem_1 1
get plan
run
```
