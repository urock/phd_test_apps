#include "nop_class.hpp"
#include <gtest/gtest.h>


TEST(NOP, SimpleTest)
{
    auto netOper = NetOper();
    EXPECT_TRUE(true);
}

TEST(NOP, ComplexTest)
{
    EXPECT_TRUE(true);
}


TEST(NOP, funcMapTests)
{
    auto netOper = NetOper();
    float result = netOper.getOperationResult(1, 10.);
    EXPECT_EQ(result, 10);
}

TEST(NOP, metrixDimensionTest)
{
    auto netOper = NetOper();
    for (auto n : {1,1,3,10,100})
    {
        netOper.setMatrixDimension(n);
        EXPECT_EQ(netOper.getMatrixDimension(), n);
    }    
}

TEST(NOP, numOfOutputsTest)
{
    auto netOper = NetOper();
    for (auto n : {2,2,5,10,100})
    {
        netOper.setOutputsNum(n);
        EXPECT_EQ(netOper.getOutputsNum(), n);
    }    
}