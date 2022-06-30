#include "nop_controller.h"
#include "nop_class.hpp"
#include <gtest/gtest.h>
#include <cmath>



TEST(Controller, ConstructorTests)
{
    
    Controller first = Controller({1., 1., 0.});
    NetOper newNetOper = NetOper();
    Controller second = Controller({1., 1., 0.}, newNetOper);

}

TEST(Controller, SimpleTest)
{
    
    Controller controller = Controller({1., 0., 0.});

    const std::vector<std::vector<int>> Psi = 
       {{0,0,0,0,  0,1,1,1,  0,2,0,0, 0,0},
       {0,0,0,0,  0,0,1,0,  2,0,0,0, 0,0},
       {0,0,0,0,  0,1,0,0,  0,0,0,0, 0,0},
       {0,0,0,0,  0,0,0,0,  0,0,1,0, 0,0},

       {0,0,0,0,  0,0,0,3,  0,0,0,0, 0,0},
       {0,0,0,0,  0,2,0,0,  0,0,1,0, 0,0},
       {0,0,0,0,  0,0,2,0,  0,0,0,1, 0,0},
       {0,0,0,0,  0,0,0,2,  0,0,0,6, 0,0},

       {0,0,0,0,  0,0,0,0,  1,3,0,0, 0,0},
       {0,0,0,0,  0,0,0,0,  0,1,0,0, 1,0},
       {0,0,0,0,  0,0,0,0,  0,0,1,0, 11,0},
       {0,0,0,0,  0,0,0,0,  0,0,0,2, 0,1},

       {0,0,0,0,  0,0,0,0,  0,0,0,0, 2,1},
       {0,0,0,0,  0,0,0,0,  0,0,0,0, 0,1}};
    std::vector<float> parameters = {0.1, 0.1, 0.1};

    controller.netOper().setOutputsNum(2);             // set Mout
    controller.netOper().setNodesForVars({0, 1});         // Pnum
    controller.netOper().setNodesForParams({2, 3, 4});    // Rnum
    controller.netOper().setNodesForOutput({13, 13});     // Dnum
    controller.netOper().setParameters(parameters);       // set Cs
    controller.netOper().setMatrix(Psi);

    State currState = {0, 0, 0};

    EXPECT_EQ(controller.distToGoal(currState), 1.);

    auto control = controller.calcControl(currState);

    std::cout << "CONTROL: ";
    for (auto i : control)
    {
        std::cout<<i << " ";
    }
    std::cout << std::endl;
}