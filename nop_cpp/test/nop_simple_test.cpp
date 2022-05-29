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
    EXPECT_EQ(netOper.getUnaryOperationResult(1, 10.), 10.);
    EXPECT_EQ(netOper.getUnaryOperationResult(2, 4.), 2.);
    EXPECT_EQ(netOper.getUnaryOperationResult(2, pow(10, 9)), pow(10, 8));
    EXPECT_EQ(netOper.getUnaryOperationResult(3, 1.), -1.);
    EXPECT_EQ(netOper.getUnaryOperationResult(4, 4.), 2.);
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