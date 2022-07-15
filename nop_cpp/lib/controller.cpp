#include "controller.hpp"
#include <cmath>
#include <iostream>

Controller::Controller(NetOper &netOper) : m_netOper(netOper) {}

Model::Control Controller::calcControl(const Model::State &currState) {
  Model::State d = Model::State{} - currState;

  std::vector<float> u(2, 0);

  m_netOper.calcResult({d.x, d.y, d.yaw}, u);
  float umax = 10.0f;

  u[0] = std::min(std::max(u[0], -umax), umax);
  u[1] = std::min(std::max(u[1], -umax), umax);

  return Model::Control{u[0], u[1]};
}
