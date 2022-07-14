#include <iostream>
#include <cmath>

#include "controller.hpp"

Controller::Controller(Model::State &goal_, NetOper &netOper):mGoal(goal_)
	,m_netOper(netOper)
{
}

Model::Control Controller::calcControl(const Model::State& currState)
{
	Model::State d = mGoal - currState;


	std::vector<float> u(2, 0);

	m_netOper.calcResult({d.x, d.y, d.yaw}, u);

   u[0] = std::max(u[0], -10.0f);
   u[0] = std::min(u[0], 10.0f);
   u[1] = std::max(u[1], -10.0f);
   u[1] = std::min(u[1], 10.0f);


	return Model::Control{u[0], u[1]};
}



void Controller::setGoal(Model::State newGoal)
{
	mGoal = newGoal;
}

NetOper& Controller::netOper()
{
	return m_netOper;
}
