#include "runner.hpp"


Runner::Runner(Model & model_, Controller & controller_, float dt_):
                mModel(model_), mController(controller_), dt(dt_)
{ 
}



void Runner::setGoal(const Model::State &goal_) {
    mGoal = goal_;
    mController.setGoal(mGoal);
}

void Runner::init(const Model::State &state_) {
    mCurrentState = state_;
}

Model::State Runner::makeStep() {

    Euler2();

    return mCurrentState; 
}

void Runner::Euler2() {

    Model::State dist_to_goal = mGoal - mCurrentState; 

    

}


