#include <cmath>
#include <gtest/gtest.h>

#include "controller.hpp"

TEST(Controller, ConstructorTests) {

  NetOper newNetOper;
  Controller second = Controller(newNetOper);
}

TEST(Controller, SimpleTest) {
  NetOper newNetOper = NetOper();
  Model::State goal = {-0.1, -0.2, 0.};
  Controller controller = Controller(newNetOper);

  std::vector<float> parameters = {0.1, 0.1, 0.1};

  // newNetOper.setOutputsNum(2);             // set Mout
  newNetOper.setNodesForVars({0, 1});      // Pnum
  newNetOper.setNodesForParams({2, 3, 4}); // Rnum
  newNetOper.setNodesForOutput({13, 13});  // Dnum
  newNetOper.setCs(parameters);            // set Cs
  newNetOper.setPsi(Psi);

  Model::State currState = {0, 0, 0};

  Model::Control u = controller.calcControl(goal);

  std::cout << "CONTROL: " << u.left << " " << u.right << "\n";

  auto desiredFunction = [](std::vector<float> x, std::vector<float> q) {
    return (pow(x[0], 2) - pow(x[1], 2)) * cos(q[0] * x[0] + q[1]) +
           x[0] * x[1] * exp(-q[2] * x[0]);
  };

  std::vector<float> x_in = {0.1, 0.2};
  Model::State dstate =  currState - goal;
  x_in[0] = dstate.x;
  x_in[1] = dstate.y;

  auto expectedResult = desiredFunction(x_in, parameters);

  EXPECT_TRUE(abs(u.left - expectedResult) < 0.001);
}
