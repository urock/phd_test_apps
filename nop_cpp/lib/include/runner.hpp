#include "model.hpp"
#include "controller.hpp"

class Runner {

    public:
        Runner(Model &, Controller &, float);
        void setGoal(const Model::State &);
        void init(const Model::State &);

        Model::State makeStep(); 

    private:
        Model::State mCurrentState;
        Model::State mGoal;
        float dt;

        Model mModel;
        Controller mController;  

        void Euler2(void);

};
