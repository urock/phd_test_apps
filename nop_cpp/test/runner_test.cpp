#include "runner.hpp"
#include <cmath>
#include <fstream>
#include <gtest/gtest.h>
#include <iostream>

TEST(Runner, FullTest) {
  // create objects
  NetOper netOp = NetOper();

  netOp.setNodesForVars({0, 1, 2});   // Pnum
  netOp.setNodesForParams({3, 4, 5}); // Rnum
  netOp.setNodesForOutput({22, 23});  // Dnum
  netOp.setCs(qc);                    // set Cs
  netOp.setPsi(NopPsiN);

  float dt = 0.01;

  Model::State currState = {0.0, 0.0, 0.0};
  Model model(currState, dt);

  Model::State goal = {0.0, 0.0, 0.0};
  Controller controller(goal, netOp);

  Runner runner(model, controller, dt);
  runner.setGoal(goal);

  // create initial states vector
  std::vector<Model::State> init_states;

  int nGraphc = 8; // num of graphs

  std::vector<float> qyminc = {-2.5, -2.5, -1.31};
  std::vector<float> qymaxc = {2.5, 2.5, 1.31};

  for (int i = 0; i <= nGraphc - 1; ++i) {
    init_states.push_back(Model::State{i & 4 ? qymaxc[0] : qyminc[0],
                                       i & 2 ? qymaxc[1] : qyminc[1],
                                       i & 1 ? qymaxc[2] : qyminc[2]});
  }

  float timeLimit = 1.5; // terminal time;
  float epsterm = 0.1;
  float sumt = 0.0, sumdelt = 0.0;

  std::ofstream runner_tests_file;
  runner_tests_file.open("runner_tests.csv");

  for (int i = 0; i <= nGraphc - 1; ++i) {
    runner.init(init_states[i]);

    float currTime = 0;
    auto plot = [&] {
      runner_tests_file << currTime << ", " << currState.x << ", "
                        << currState.y << ", " << currState.yaw << '\n';
    };

    currState = init_states[i];
    while (currTime < timeLimit) {

      plot();

      auto pastState = currState;
      currState = runner.makeStep();
      currTime += dt;

      // if (currState.dist(goal) < epsterm || currState==pastState)
      if (currState.dist(goal) < epsterm)
        break;
    }
    plot();

    sumt += currTime;
    sumdelt += currState.dist(goal);
  }

  std::cout << sumt << " " << sumdelt << "\n";

  float sumdelt_golden = 0.870068;
  float sumt_golden = 6.3;

  runner_tests_file.close();

  EXPECT_TRUE(abs(sumt - sumt_golden) < 0.01);
  EXPECT_TRUE(abs(sumdelt - sumdelt_golden) < 0.01);
}
