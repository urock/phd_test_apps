#pragma once

#include "controller.hpp"

class Runner {

public:
  Runner(Model &, Controller &, float);
  void init(const Model::State &);
  void setGoal(const Model::State &);

  Model::State makeStep();
  const Model::State &getState();

  void Euler2(void);

private:
  Controller mController;
  Model mModel;
  Model::State mGoal;
  float dt;
  float mCurrentTime;
};
