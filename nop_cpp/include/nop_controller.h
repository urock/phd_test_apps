#pragma once

#include "nop_class.hpp"
#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

// will be replaced with "state" from Model class
struct State
{
	float x;
	float y;
	float yaw;

};

// class network operator
class Controller
{

public:
	Controller(State goalState, NetOper netOper = NetOper());

	/// RP from pascal version
	std::vector<float> calcControl(const State& currState);
	/// NormdistBetweenStateAndGoal
	float distToGoal(const State& currState);
	/// set new goal state
	void setGoal(State newGoal);
	/// returns curr goal state
	const State& goal();
	/// returns nnetwork operator
	const NetOper& netOper();

private:

	State m_goalState = {0., 0.1, 0.1};
	NetOper m_netOper;
	const float Eps = 0.1; // [m]
};