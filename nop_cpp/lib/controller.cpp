#include <iostream>
#include <cmath>

#include "controller.hpp"

Controller::Controller(Model::State goal_, NetOper netOper):mGoal(goal_)
	,m_netOper(netOper)
{
}

Model::Control Controller::calcControl(const Model::State& currState)
{	
	Model::State d = mGoal - currState; 


	std::vector<float> u(2, 0);

	m_netOper.calcResult({d.x, d.y, d.yaw}, u);

	
	return Model::Control{u[0], u[1]};
}

// bullshit
// TODO rework
/*   
	sum:=0;
   
   dx := abs(Goal.x - state.x);
   if dx > sum then
      sum := dx;
   
   dy := abs(Goal.y - state.y);
   if dy > sum then
      sum := dy;
   
   dyaw := abs(Goal.yaw - state.yaw);
   if dyaw > sum then
      sum := dyaw;

   result:=sum;
  */
// float Controller::distToGoal(const State& currState)
// {
// 	float dx = m_goalState.x - currState.x;
// 	float dy = m_goalState.y - currState.y;
// 	float dyaw = m_goalState.yaw - currState.yaw;

// 	// comparison of meters and radians looks like crap
// 	return std::max(std::max(dx, dy), dyaw);

// }

void Controller::setGoal(Model::State newGoal)
{
	mGoal = newGoal;
}

NetOper& Controller::netOper()
{
	return m_netOper;
}
