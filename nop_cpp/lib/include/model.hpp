#pragma once
#include <iostream>
#include <vector>
#include <cmath>

constexpr float pi = 3.1415927;

constexpr float radr(float angle) {
  if (angle >= pi)
    return radr(angle - 2 * pi);
  else if (angle < -pi)
    return radr(angle + 2 * pi);
  else
    return angle;
}

class Model {

public:
  struct Control {
    float left;
    float right;

    Control operator+(const Control &ctrl) const {
      return Control{this->left + ctrl.left, this->right + ctrl.right};
    }
    Control operator-(const Control &ctrl) const {
      return Control{this->left - ctrl.left, this->right - ctrl.right};
    }
    Control operator*(float val) const {
      return Control{this->left * val, this->right * val};
    }

  };

  struct State {
    float x;
    float y;
    float yaw;

    State operator+(const State &state) const {
      return State{this->x + state.x, this->y + state.y, radr(this->yaw + state.yaw)};
    }
    State operator-(const State &state) const {
      return State{this->x - state.x, this->y - state.y, radr(this->yaw - state.yaw)};
    }
    State operator*(float val) const {
      return State{this->x * val, this->y * val, radr(this->yaw * val)};
    }

    bool operator==(const State &state) const {
      return (this->x == state.x)&& (this->y == state.y)&& (radr(this->yaw) == radr(state.yaw));
    }

    float dist(const State &state) {
        float dx = fabs(this->x - state.x);
        float dy = fabs(this->y - state.y);
        float dyaw = fabs(radr(this->yaw) - radr(state.yaw));

      // comparison of meters and radians looks like crap
      // return std::max(std::max(dx, dy), dyaw);
        return std::sqrt(dx * dx + dy * dy + dyaw * dyaw);
    }

  };

  Model(State &, float);

  void setState(const State &);
  void setState(const Control &);
  const State &getState();

  State calcDeltaState(const Control &);

  State calcState(const Control &);
  State calcState(const State &);

private:
  float k = 0.5f;

  State &mCurrentState;
  float dt;
};
