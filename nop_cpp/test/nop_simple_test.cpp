#include "nop_class.hpp"
#include <gtest/gtest.h>


TEST(NOP, Test)
{
    auto netOper = NetOper();
    EXPECT_TRUE(true);
}

TEST(NOP, SimpleTest)
{   

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

    auto netOper = NetOper();
    // netOper.setMatrixDimension(14);          // set L
    netOper.setOutputsNum(2);                // set Mout
    netOper.setNodesForVars({0, 1});         // Pnum
    netOper.setNodesForParams({2, 3, 4});    // Rnum
    netOper.setNodesForOutput({13, 13});     // Dnum
    netOper.setParameters({0.1, 0.1});       // set Cs

    netOper.setMatrix(Psi);

    std::vector<float> initialState = {0.1, 0.1};
    std::vector<float> control = {0.1, 0.1};
    netOper.solveRP(initialState, control);

     std::cout<<"RP RESULT: "<<control[0]<<" "<<control[1]<< std::endl;

//     EXPECT_TRUE(true);
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

// // TODO FIX MATRIX DIM ISSUE!
// TEST(NOP, metrixDimensionTest)
// {
    
//     // auto compareDimensions = [](size_t dim, 
//     //     const std::vector<std::vector<int>>& matrix)
//     // {

//     // };

//     auto netOper = NetOper();
//     for (auto n : {1,1,3,10,100})
//     {
//         netOper.setMatrixDimension(n);
//         EXPECT_EQ(netOper.getMatrixDimension(), n);
//     }    
// }

TEST(NOP, numOfOutputsTest)
{
    auto netOper = NetOper();
    for (auto n : {2,2,5,10,100})
    {
        netOper.setOutputsNum(n);
        EXPECT_EQ(netOper.getOutputsNum(), n);
    }    
}

TEST(NOP, nodesForVarsTest)
{
    auto netOper = NetOper();
    std::vector<int> nodesForVars = {0, 1, 2, 3};
    netOper.setNodesForVars(nodesForVars);
    EXPECT_TRUE(nodesForVars == netOper.getNodesForVars());
}

TEST(NOP, nodesForParamsTest)
{
    auto netOper = NetOper();
    std::vector<int> nodesForParams = {2, 3, 4, 5};
    netOper.setNodesForParams(nodesForParams);
    EXPECT_TRUE(nodesForParams == netOper.getNodesForParams());
}

TEST(NOP, nodesForParamsOutputTest)
{
    auto netOper = NetOper();
    std::vector<int> nodesForOutput = {13, 13};
    netOper.setNodesForOutput(nodesForOutput);
    EXPECT_TRUE(nodesForOutput == netOper.getNodesForOutput());
}

TEST(NOP, ParametersTest)
{
    auto netOper = NetOper();
    std::vector<float> parameters = {0.1, 0.1};
    netOper.setParameters(parameters);
    EXPECT_TRUE(parameters == netOper.getParameters());
}

TEST(NOP, setMatrixTest)
{
    auto netOper = NetOper();
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
    
    netOper.setMatrix(Psi);

    EXPECT_TRUE(Psi == netOper.getMatrix());
}