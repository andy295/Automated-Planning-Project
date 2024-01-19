cmake_minimum_required(VERSION 3.5)
project(plansys2)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_action REQUIRED)
find_package(plansys2_msgs REQUIRED)
find_package(plansys2_executor REQUIRED)

set(CMAKE_CXX_STANDARD 17)

set(dependencies
	rclcpp
	rclcpp_action
	plansys2_msgs
	plansys2_executor
)

add_executable(attach_carrier_action_node src/attach_carrier_action_node.cpp)
ament_target_dependencies(attach_carrier_action_node ${dependencies})

add_executable(deliver_supply_action_node src/deliver_supply_action_node.cpp)
ament_target_dependencies(deliver_supply_action_node ${dependencies})

add_executable(detach_carrier_action_node src/detach_carrier_action_node.cpp)
ament_target_dependencies(detach_carrier_action_node ${dependencies})

add_executable(empty_box_actione_node src/empty_box_actione_node.cpp)
ament_target_dependencies(empty_box_actione_node ${dependencies})

add_executable(fill_box_action_node src/fill_box_action_node.cpp)
ament_target_dependencies(fill_box_action_node ${dependencies})

add_executable(free_robot_action_node src/free_robot_action_node.cpp)
ament_target_dependencies(free_robot_action_node ${dependencies})

add_executable(load_carrier_action_node src/load_carrier_action_node.cpp)
ament_target_dependencies(load_carrier_action_node ${dependencies})

add_executable(load_robot_action_node src/load_robot_action_node.cpp)
ament_target_dependencies(load_robot_action_node ${dependencies})

add_executable(move_action_node src/move_action_node.cpp)
ament_target_dependencies(move_action_node ${dependencies})

add_executable(pick_box_from_carrier_action_node src/pick_box_from_carrier_action_node.cpp)
ament_target_dependencies(pick_box_from_carrier_action_node ${dependencies})

install(DIRECTORY launch pddl DESTINATION share/${PROJECT_NAME})

install(TARGETS
	attach_carrier_action_node
	deliver_supply_action_node
	detach_carrier_action_node
	empty_box_actione_node
	fill_box_action_node
	free_robot_action_node
	load_carrier_action_node
	load_robot_action_node
	move_action_node
	pick_box_from_carrier_action_node

	ARCHIVE DESTINATION lib
	LIBRARY DESTINATION lib
	RUNTIME DESTINATION lib/${PROJECT_NAME}
)

if(BUILD_TESTING)
	find_package(ament_lint_auto REQUIRED)
	ament_lint_auto_find_test_dependencies()

	find_package(ament_cmake_gtest REQUIRED)
endif()

ament_export_dependencies(${dependencies})

ament_package()
