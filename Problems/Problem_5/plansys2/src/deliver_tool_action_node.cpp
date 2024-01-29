#include <memory>
#include <algorithm>

#include "plansys2_executor/ActionExecutorClient.hpp"

#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class DeliveryTool : public plansys2::ActionExecutorClient
{
	public:
		DeliveryTool()
		: plansys2::ActionExecutorClient("deliver_tool", 250ms)
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
				send_feedback(progress_, "Delivering in progress");
			}
			else
			{
				finish(true, 1.0, "Tool delivered");

				progress_ = 0.0;
				std::cout << std::endl;
			}

			std::cout << "\r\e[K" << std::flush;
			std::cout << "Tool delivering ... [" << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush;
		}
};

int main(int argc, char ** argv)
{
	rclcpp::init(argc, argv);
	auto node = std::make_shared<DeliveryTool>();

	node->set_parameter(rclcpp::Parameter("action_name", "deliver_tool"));
	node->trigger_transition(lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

	rclcpp::spin(node->get_node_base_interface());

	rclcpp::shutdown();
	return 0;
}
