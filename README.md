# Automated Planning Project - Warehouse Distribution Center

## Overview

The project aims to implement an automatic warehouse distribution solution. Its development involves solving five different problems, each presenting an increasing level of difficulty.

The project relies on the PDDL and HDDL languages and six different planning tools, each chosen to address specific needs related to the proposed problems.

## Project Sturcture

The project has been divided into five different folders, each dedicated to a specific problem and containing primarily `domain`, `problem`, and `Results` files.

Additionally, some other files necessary for the proper functioning of the solution may be found as needed.

- **Problem 1**
	- Objective: A robot delivers tools to workstations.
	- Tool: Planutils
	- Planner: LAMA-First
	- Content:
	```bash
		├── domain.pddl
		├── problem.pddl
		└── Results.md
	```

- **Problem 2**
	- Objective: A robot delivers tools to workstations. However, this time, it must use a carrier, and it is mandatory to keep track of the number of loaded tools.
	- Tool: Planutils
	- Planner: LAMA and Metric-ff
	- Content:
	```bash
		├── Classical
		│   ├── domain.pddl
		│   └── problem.pddl
		├── Fluent
		│   ├── domain.pddl
		│   ├── problem_1.pddl
		│   └── problem_2.pddl
		└── Results.md
	```

- **Problem 3**
	- Objective: Repropose the solution to the previous problem, but this time using the Hierarchical Task Network (HTN).
	- Tool: Java Virtual Machine (JVM)
	- Planner: PANDA
	- Content:
	```bash
		├── doamin.hddl
		├── problem.hddl
		├── PANDA.jar
		└── Results.md
	```

- **Problem 4**
	- Objective: Expand the proposed solution for problem 2 by introducing the concept of time through durative actions.
	- Tool: Planutils
	- Planner: Optic
	- Content:
	```bash
		├── doamin.pddl
		├── problem_1.pddl
		├── problem_2.pddl
		└── Results.md
	```

- **Problem 5**
	- Objective: Implement the solution to the previous problem , but this time using the Hierarchical Task Network (HTN).
	- Tool: PlanSys2 and ROS2
	- Planner: POPF
	- Content:
	```bash
		├── plansys2
		│   ├── CMakeLists.txt
		│   ├── package.xml
		│   ├── Results.md
		│   ├── terminal_1_compile_and_run.sh
		│   ├── terminal_2_run.sh
		│   ├── launch
		│   │   └── problem_5_launch.py
		│   ├── pddl
		│   │   ├── domain.pddl
		│   │   ├── problem_1
		│   │   └── problem_2
		│   └── src
		│       ├── attach_carrier_action_node.cpp
		│       ├── deliver_supply_action_node.cpp
		│       ├── detach_carrier_action_node.cpp
		│       ├── empty_box_actione_node.cpp
		│       ├── empty_carrier_action_node.cpp
		│       ├── fill_box_action_node.cpp
		│       ├── load_carrier_action_node.cpp
		│       └── move_robot_action_node.cpp
		├── Results
		│   ├── Problem_1
		│   │   ├── Plan.png
		│   │   └── Source.png
		│   └── Problem_2
		│       ├── Plan.png
		│       ├── Source_part_1.png
		│       └── Source_part_2.png
		└── Setup.md
	```

## Usage

To use the proposed solutions, it is necessary to install the planning tools and configure the development environment.

For solutions to problems 1, 2, and 4, [Planutils](https://github.com/AI-Planning/planutils) tool was used because it provides the user with a wide variety of planners that are easily installable and ready to use.

In solving problem 3, [PANDA](https://www.uni-ulm.de/en/in/ki/research/software/panda/panda-planning-system/) was used, a planner mainly developed in Java for which it is necessary to install the [Java Virtual Machine](https://www.java.com/en/download/manual.jsp).

Finally, to address problem 5, [PlanSys2](https://github.com/PlanSys2/ros2_planning_system) along with [ROS2](https://docs.ros.org/en/humble/), were required.

For correct installation and configuration of the tools, please refer to the official documentation.

The project was developed and tested on Ubuntu 20.04 LTS and Ubuntu 22.04 LTS. However, with appropriate adjustments, it is possible to use the proposed solutions on other operating systems and/or planning systems.

Inside the Results.md file for each problem, it is possible to find instructions for executing the proposed solutions.

More details about the development of the project can be found in the [Report]().
