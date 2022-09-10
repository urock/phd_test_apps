#include "runner.hpp"


Runner::Runner(Model& model_, Controller& controller_):
                mModel(model_)
                ,mController(controller_)
{ 
}



void Runner::setGoal(const Model::State &goal_) {
    // mGoal = goal_;
    mController.setGoal(goal_);
}

void Runner::init(const Model::State &state_) {
    mModel.setState(state_);
}

void Runner::Euler2() {

    // Model::State initialState = mModel.getState();

    // Model::Control u1 = mController.calcControl(mModel.getState());
    // Model::State v1 = mModel.calcVelocity(u1); // fa
    // Model::State s1 = mModel.calcState(v1); // moved state

    // Model::Control u2 = mController.calcControl(s1);
    // mModel.setState(s1);
    // Model::State v2 = mModel.calcVelocity(u2); // fb
    
    // mModel.setState(initialState);
    // Model::State ctrl = (v1 + v2) * 0.5;
    // Model::State movedState = mModel.calcState(ctrl);

    // mModel.setState(movedState);
      std::vector<float> fa(3);
      std::vector<float> fb(3);
      float dt = 0.01;
      
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

      newState.x = mModel.getState().x + dt * (fa[0]+fb[0]) / 2.0;
      newState.y = mModel.getState().y + dt * (fa[1]+fb[1]) / 2.0;
      newState.yaw = mModel.getState().yaw + dt * (fa[2]+fb[2]) / 2.0;

      mModel.setState(newState);

}

Model::State Runner::makeStep() {

    Euler2();

    return mModel.getState(); 
}




