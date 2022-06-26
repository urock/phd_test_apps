#pragma once
#include <vector>

class Model {

public:
  using Control = std::vector<float>;

  struct State {
    float x;
    float y;
    float yaw;
    const State operator+(const State &);
    const State operator*(float);
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
