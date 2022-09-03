#include "runner.hpp"

Runner::Runner(Model &model_, Controller &controller_, float &dt_)
    : mController(controller_)
    , mModel(model_)
    , dt(dt_)
    , mCurrentTime(0.0) 
    {

    }

void Runner::Euler2() {

  std::vector<float> fa(3);
  std::vector<float> fb(3);

  auto u1 = mController.calcControl(mModel.getState());

  fa[0] = 0.5 * (u1.left + u1.right) * cosf(mModel.getState().yaw);
  fa[1] = 0.5 * (u1.left + u1.right) * sinf(mModel.getState().yaw);
  fa[2] = 0.5 * (u1.left - u1.right);

  Model::State movedState;

  movedState.x = mModel.getState().x + dt * fa[0];
  movedState.y = mModel.getState().y + dt * fa[1];
  movedState.yaw = mModel.getState().yaw + dt * fa[2];

  auto u2 = mController.calcControl(movedState);

  fb[0] = 0.5 * (u2.left + u2.right) * cosf(movedState.yaw);
  fb[1] = 0.5 * (u2.left + u2.right) * sinf(movedState.yaw);
  fb[2] = 0.5 * (u2.left - u2.right);
  
  Model::State newState;

  newState.x = mModel.getState().x + dt * (fa[0]+fb[0]) / 2;
  newState.y = mModel.getState().y + dt * (fa[1]+fb[1]) / 2;
  newState.yaw = mModel.getState().yaw + dt * (fa[2]+fb[2]) / 2;

  mModel.setState(newState);
  


  mCurrentTime += dt;
}

Model::State Runner::makeStep() {

  Euler2();
  return mModel.getState();
}
