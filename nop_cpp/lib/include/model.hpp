
#pragma once
#include <iostream>
#include <vector>
#include <cmath>

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
      return State{this->x + state.x, this->y + state.y, this->yaw + state.yaw};
    }
    State operator-(const State &state) const {
      return State{this->x - state.x, this->y - state.y, this->yaw - state.yaw};
    }
    State operator*(float val) const {
      return State{this->x * val, this->y * val, this->yaw * val};
    }

    bool operator==(const State &state) const {
      return (this->x == state.x)&& (this->y == state.y)&& (this->yaw == state.yaw);
    }

    float dist(const State &state) {
        float dx = fabs(this->x - state.x);
        float dy = fabs(this->y - state.y);
        float dyaw = fabs(this->yaw - state.yaw);

        // comparison of meters and radians looks like crap
        // return std::max(std::max(dx, dy), dyaw);
        return std::max(dx, dy);
      }

    void print() {
        std::cout << x << " " << y << " " << yaw << "\n";
  };

  Model(const State &, float);

  void setState(const State &);
  void setState(const Control &);
  const State &getState();

  State calcDeltaState(const Control &);

  State calcState(const Control &);
  State calcState(const State &);

private:
  float k = 0.5f;

  State mCurrentState;
  float dt;
};
