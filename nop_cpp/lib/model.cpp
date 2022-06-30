#include "model.hpp"
#include <cmath>

Model::Model(const State &state_, float dt_): 
        m_state(state_), dt(dt_) {}

void Model::setState(const State &state_) { m_state = state_; }

const Model::State &Model::getState() { return m_state; }

Model::State Model::calcVelocity(const Control &u) {
  return  State{k * (u.left + u.right) * cosf(m_state.yaw),
                k * (u.left + u.right) * sinf(m_state.yaw),
                k * (u.left - u.right)};
}

Model::State Model::calcState(const Control &u) {
  auto Vs = calcVelocity(u);
  return m_state + Vs * dt;
}

Model::State Model::calcState(State &Vs) {
  return m_state + Vs * dt;
}





