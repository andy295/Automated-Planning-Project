# Problem 5

## Commands
Two options are available to run the problem:

### Option 1

#### Terminal 1
Open the first terminal and run the following commands:
```bash
# move to the workspace
cd ~/<path>/Problem_5/plansys2

# to make the script executable (only once)
chmod +x terminal_1_compile_and_run.sh

# run the script
./terminal_1_compile_and_run.sh
```

#### Terminal 2
Open the second terminal and run the following commands:
```bash
# move to the workspace
cd ~/<path>/Problem_5/plansys2

# to make the script executable (only once)
chmod +x terminal_2_run

# run the script
./terminal_2_run.sh
```

### Option 2

#### Terminal 1
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

#### Terminal 2
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
```

### Finals steps
After starting ROS2, execute the following commands:

```bash
# ROS2 commands
source pddl/problem_<version> 1
get plan
run
```
