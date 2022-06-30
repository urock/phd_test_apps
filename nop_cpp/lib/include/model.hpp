#pragma once
#include <iostream>
#include <vector>

class Model {

public:
  struct Control {
    // Control(float u1, float u2):left(u1), right(u2) {}
    float left;
    float right;
  };

  struct State {
    float x;
    float y;
    float yaw;
    const State operator+(const State &state) {
      return State{this->x + state.x, this->y + state.y, this->yaw + state.yaw};
    }
    const State operator-(const State &state) {
      return State{this->x - state.x, this->y - state.y, this->yaw - state.yaw};
    }
    const State operator*(float val) {
      return State{this->x * val, this->y * val, this->yaw * val};
    }
  };


  Model();
  Model(const State &);
  void reset(const State &);
  void applyControl(const Control &, float);
  const State getNext(const Control &, float);
  const State &getState();

private:
  const State calcState(const Control &, float);
  void setState(const State &);

  State m_state;
};
