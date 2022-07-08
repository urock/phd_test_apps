#include "model.hpp"
#include <cmath>
#include <gtest/gtest.h>

TEST(Model, setState) {
  Model model({0, 0, 0}, 1);
  model.setState(Model::State{1, 1, 1});
  EXPECT_EQ(model.getState().yaw, 1);
}

TEST(Model, calcState) {
  EXPECT_EQ(Model({1, 0, 0}, 1).calcState(Model::Control{1, 1}).x, 2);
  EXPECT_EQ(Model({1, 0, 0}, 1).calcState(Model::State{-1, 0, 0}).x, 0);
}
