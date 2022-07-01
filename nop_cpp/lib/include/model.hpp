#pragma once
#include <iostream>
#include <vector>

class Model {

public:
  struct Control {
    float left;
    float right;
  };

  struct State {
    float x;
    float y;
    float yaw;
    State operator+(const State &state) {
      return State{this->x + state.x, this->y + state.y, this->yaw + state.yaw};
    }
    State operator-(const State &state) {
      return State{this->x - state.x, this->y - state.y, this->yaw - state.yaw};
    }
    State operator*(float val) {
      return State{this->x * val, this->y * val, this->yaw * val};
    }
  };


  Model(const State &state, float dt_);
  void setState(const State &);
  const State &getState();
  
  State calcVelocity(const Control &) ;

  State calcState(const Control &u);
  State calcState(State &Vs) ;


private:
  float k = 0.5f;
  
  State mCurrentState;
  float dt; 
};
