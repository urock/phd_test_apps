#include "model.hpp"
#include <cmath>
#include <gtest/gtest.h>

TEST(Model, ConstructorTests) {
  Model first = Model();
  Model::State state{12.2, -2.4, -0.3};
  Model second = Model(state);
}

TEST(Model, reset) {
  Model model({-10, 0, 0});
  Model::State state{1, 0, 0};
  model.reset(state);
  EXPECT_EQ(model.getState().x, 1.);
}

TEST(Model, getNext) {
  Model model({1, 0, 0});
  Model::Control control = {1, 1};
  EXPECT_EQ(model.getNext(control, 1).x, 2);
}
