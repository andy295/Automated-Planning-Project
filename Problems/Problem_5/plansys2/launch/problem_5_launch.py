# Copyright 2019 Intelligent Robotics Lab
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node

# The launcher contains the information to create the problem instance
# and the details required to activate the various nodes.
def generate_launch_description():

	# Get the launch directory
	example_dir = get_package_share_directory('plansys2')
	namespace = LaunchConfiguration('namespace')

	declare_namespace_cmd = DeclareLaunchArgument(
		'namespace',
		default_value='',
		description='Namespace')

	plansys2_cmd = IncludeLaunchDescription(
		PythonLaunchDescriptionSource(os.path.join(
			get_package_share_directory('plansys2_bringup'),
			'launch',
			'plansys2_bringup_launch_monolithic.py')),

		# Specify the location of the model file
		# and indicate the namespace to be used
		launch_arguments={
			'model_file': example_dir + '/pddl/domain.pddl',
			'namespace': namespace
			}.items())

	# Specify the actions
	attach_carrier_action_node_cmd = Node(
		package='plansys2',
		executable='attach_carrier_action_node',
		name='attach_carrier_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	deliver_supply_action_node_cmd = Node(
		package='plansys2',
		executable='deliver_supply_action_node',
		name='deliver_supply_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	detach_carrier_action_node_cmd = Node(
		package='plansys2',
		executable='detach_carrier_action_node',
		name='detach_carrier_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	empty_box_actione_node_cmd = Node(
		package='plansys2',
		executable='empty_box_actione_node',
		name='empty_box_actione_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	fill_box_action_node_cmd = Node(
		package='plansys2',
		executable='fill_box_action_node',
		name='fill_box_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	free_robot_action_node_cmd = Node(
		package='plansys2',
		executable='free_robot_action_node',
		name='free_robot_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	load_carrier_action_node_cmd = Node(
		package='plansys2',
		executable='load_carrier_action_node',
		name='load_carrier_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	load_robot_action_node_cmd = Node(
		package='plansys2',
		executable='load_robot_action_node',
		name='load_robot_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	move_robot_cmd = Node(
		package='plansys2',
		executable='move_action_node',
		name='move_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	pick_box_from_carrier_action_node_cmd = Node(
		package='plansys2',
		executable='pick_box_from_carrier_action_node',
		name='pick_box_from_carrier_action_node',
		namespace=namespace,
		output='screen',
		parameters=[])

	# Create an instance of the launch description and populate it
	ld = LaunchDescription()

	# Add the declared namespace defined above
	ld.add_action(declare_namespace_cmd)

	# Add the launch options defined above
	ld.add_action(plansys2_cmd)

	ld.add_action(attach_carrier_action_node_cmd)
	ld.add_action(deliver_supply_action_node_cmd)
	ld.add_action(detach_carrier_action_node_cmd)
	ld.add_action(empty_box_actione_node_cmd)
	ld.add_action(fill_box_action_node_cmd)
	ld.add_action(free_robot_action_node_cmd)
	ld.add_action(load_carrier_action_node_cmd)
	ld.add_action(load_robot_action_node_cmd)
	ld.add_action(move_robot_cmd)
	ld.add_action(pick_box_from_carrier_action_node_cmd)

	# Return the launch descriptor
	return ld
