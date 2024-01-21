#include <memory>
#include <algorithm>

#include "plansys2_executor/ActionExecutorClient.hpp"

#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class LoadCarrier : public plansys2::ActionExecutorClient
{
	public:
		LoadCarrier()
		: plansys2::ActionExecutorClient("load_carrier", 250ms)
		{
			progress_ = 0.0;
			calls = duration / 500.0;
			increment = 1.0 / calls;
		}

	private:
		double duration = 2500.0;
		double progress_;
		double calls;
		double increment;

		void do_work()
		{
			if (progress_ < 1.0)
			{
				progress_ += increment;
				send_feedback(progress_, "Loading box within the carrier in progress");
			}
			else
			{
				finish(true, 1.0, "Carried loaded");

				progress_ = 0.0;
				std::cout << std::endl;
			}

			std::cout << "\r\e[K" << std::flush;
			std::cout << "Loading carrier ... [" << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush;
		}
};

int main(int argc, char ** argv)
{
	rclcpp::init(argc, argv);
	auto node = std::make_shared<LoadCarrier>();

	node->set_parameter(rclcpp::Parameter("action_name", "load_carrier"));
	node->trigger_transition(lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

	rclcpp::spin(node->get_node_base_interface());

	rclcpp::shutdown();
	return 0;
}
