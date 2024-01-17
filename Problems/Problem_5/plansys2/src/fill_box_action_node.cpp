#include <memory>
#include <algorithm>

#include "plansys2_executor/ActionExecutorClient.hpp"

#include "rclcpp/rclcpp.hpp"
#include "rclcpp_action/rclcpp_action.hpp"

using namespace std::chrono_literals;

class FillBox : public plansys2::ActionExecutorClient
{
	public:
		FillBox()
		: plansys2::ActionExecutorClient("fill_box", 500ms)
		{
			progress_ = 0.0;
			calls = duration / 500.0;
			increment = 1.0 / calls;
		}

	private:
		const static double duration = 5000.0;

		double progress_;
		double calls;
		double increment;

		void do_work()
		{
			if (progress < 1.0)
			{
				progress += increment;
				send_feedback(progress_, "Filling box in progress");
			}
			else
			{
				finish(true, 1.0, "Box filled");

				progress_ = 0.0;
				std::cout << std::endl;
			}

			std::cout << "\r\e[K" << std::flush;
			std::cout << "Filling box ... [" << std::min(100.0, progress_ * 100.0) << "%]  " << std::flush;
		}
};

int main(int argc, char ** argv)
{
	rclcpp::init(argc, argv);
	auto node = std::make_shared<FillBox>();

	node->set_parameter(rclcpp::Parameter("action_name", "fill_box"));
	node->trigger_transition(lifecycle_msgs::msg::Transition::TRANSITION_CONFIGURE);

	rclcpp::spin(node->get_node_base_interface());

	rclcpp::shutdown();
	return 0;
}