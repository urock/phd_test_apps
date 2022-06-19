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