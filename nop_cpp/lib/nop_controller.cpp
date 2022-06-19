#include "nop_controller.h"
#include <iostream>
#include <cmath>

Controller::Controller(State goalState, NetOper netOper):m_goalState(goalState)
	,m_netOper(netOper)
{
	std::cout<<"Init Controller" << std::endl;
}

std::vector<float> Controller::calcControl(const State& currState)
{	
	// 
	std::vector<float> result(3, 0);
	if (distToGoal(currState) < Eps)
		return result;

	constexpr float k = 0.5; // some koeff will be
	float dx = m_goalState.x - currState.x;
	float dy = m_goalState.y - currState.y;
	float dyaw = m_goalState.yaw - currState.yaw;


	// todo currState.getNumOfControInput
	std::vector<float> intermResult(2, 0);

	m_netOper.calcResult({dx, dy, dyaw}, intermResult);

	result[0] = k * (intermResult[0] + intermResult[1]) * cos(currState.yaw);
	result[1] = k * (intermResult[0] + intermResult[1]) * sin(currState.yaw);
	result[2] = k * (intermResult[0] - intermResult[1]);

	return result;
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
float Controller::distToGoal(const State& currState)
{
	float dx = m_goalState.x - currState.x;
	float dy = m_goalState.y - currState.y;
	float dyaw = m_goalState.yaw - currState.yaw;

	// comparison of meters and radians looks like crap
	return std::max(std::max(dx, dy), dyaw);

}

void Controller::setGoal(State newState)
{
	m_goalState = newState;
}

const State& Controller::goal()
{
	return m_goalState;
}

const NetOper& Controller::netOper()
{
	return m_netOper;
}
