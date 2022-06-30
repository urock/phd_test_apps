#include "model.hpp"
#include <cmath>

const Model::State Model::State::operator+(const State &state) {
  return State{this->x + state.x, this->y + state.y, this->yaw + state.yaw};
}

const Model::State Model::State::operator*(float val) {
  return State{this->x * val, this->y * val, this->yaw * val};
}

Model::Model() {}
Model::Model(const State &state) { setState(state); }

void Model::reset(const State &state) { setState(state); }

void Model::setState(const State &state) { m_state = state; }

const Model::State Model::calcState(const Control &control, const float dt) {
  constexpr float k = 0.5f;
  auto Vs = State{k * (control.left + control.right) * cosf(m_state.yaw),
                  k * (control.left + control.right) * sinf(m_state.yaw),
                  k * (control.left - control.right)};
  return m_state + Vs * dt;
}

void Model::applyControl(const Control &control, const float dt) {
  setState(calcState(control, dt));
}

const Model::State Model::getNext(const Control &control, const float dt) {
  return calcState(control, dt);
}

const Model::State &Model::getState() { return m_state; };
