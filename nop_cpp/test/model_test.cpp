#include "model.hpp"
#include <cmath>
#include <gtest/gtest.h>

std::ostream &operator<<(std::ostream &os, const Model::State &state) {
  os << state.x << ' ' << state.y << ' ' << state.yaw;
  return os;
}

TEST(Model, setget) {
  Model model({0, 0, 0}, 1);
  Model::State state{1, 1, 0};
  Model::State state2{2, 1, 0};
  model.setState(state);
  EXPECT_TRUE(model.getState() == state);
  model.setState(Model::Control{1, 1});
  EXPECT_TRUE(model.getState() == state2);
}

TEST(Model, calcState) {
  EXPECT_EQ(Model({1, 0, 0}, 1).calcState(Model::Control{1, 1}).x, 2);
  EXPECT_EQ(Model({1, 0, 0}, 1).calcState(Model::State{-1, 0, 0}).x, 0);
}

TEST(State, dist) {
  Model::State state1{1, 0, 1};
  Model::State state2{2, -1, 2};

  EXPECT_TRUE(fabs(state1.dist(state2) - sqrt(3)) < 0.0001);
  EXPECT_TRUE(fabs(state2.dist(state1) - sqrt(3)) < 0.0001);
}

TEST(State, operators) {
  Model::State state1{1, 2, 3};
  Model::State state2{3, -2, 1};
  Model::State state_sum{4, 0, 4};
  Model::State state_diff{-2, 4, 2};
  float k = 0.23;
  Model::State state_prod{k, 2 * k, 3 * k};

  EXPECT_TRUE(state1 == state1);
  EXPECT_TRUE(!(state1 == state2));
  EXPECT_EQ(state1 + state2, state_sum);
  EXPECT_EQ(state1 - state2, state_diff);
  EXPECT_EQ(state1 * k, state_prod);
}

TEST(Control, operators) {
  Model::State state1{1, 2};
  Model::State state2{3, -2};
  Model::State state_sum{4, 0};
  Model::State state_diff{-2, 4};
  float k = 0.23;
  Model::State state_prod{k, 2 * k};

  EXPECT_EQ(state1 + state2, state_sum);
  EXPECT_EQ(state1 - state2, state_diff);
  EXPECT_EQ(state1 * k, state_prod);
}
