#include "nop_class.hpp"
#include <gtest/gtest.h>
#include <cmath>

TEST(NOP, Test)
{
    auto netOper = NetOper();
    EXPECT_TRUE(true);
}

TEST(NOP, SimpleTest)
{   
    auto desiredFunction = [](std::vector<float> x,
                               std::vector<float> q)
    {
        return (pow(x[0], 2) - pow(x[1], 2)) * cos(q[0] * x[0] + q[1]) + x[0]*x[1]*exp(-q[2] * x[0]);
    };

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
    auto netOper = NetOper();
    netOper.setOutputsNum(2);                // set Mout
    netOper.setNodesForVars({0, 1});         // Pnum
    netOper.setNodesForParams({2, 3, 4});    // Rnum
    netOper.setNodesForOutput({13, 13});     // Dnum
    netOper.setParameters(parameters);       // set Cs

    netOper.setMatrix(Psi);

    std::vector<float> initialState = {0.1, 0.1};

    auto expectedResult = desiredFunction(initialState, parameters);


    std::vector<float> NOPOutput(2);
    netOper.solveRP(initialState, NOPOutput);


    std::cout << "desiredFunction RESULT: " << expectedResult << std::endl;
    
    std::cout<<"RP RESULT: "<< NOPOutput[0] <<" "<< NOPOutput[1]<< std::endl;

    EXPECT_EQ(NOPOutput[0], expectedResult);
    

}


TEST(NOP, funcMapTests)
{
    
    auto netOper = NetOper();
    auto a = 24.23;
    auto big_inf = pow(10,9);
    auto b = 7892.02;
    EXPECT_EQ(netOper.getUnaryOperationResult(1, a), ro_1(a));
    EXPECT_EQ(netOper.getUnaryOperationResult(2, a), ro_2(a));
    EXPECT_EQ(netOper.getUnaryOperationResult(2, big_inf), ro_2(big_inf));
    EXPECT_EQ(netOper.getUnaryOperationResult(3, a), ro_3(a));
    EXPECT_EQ(netOper.getUnaryOperationResult(4, a), ro_4(a));

    EXPECT_EQ(netOper.getBinaryOperationResult(1, a, b), xi_1(a, b));
    EXPECT_EQ(netOper.getBinaryOperationResult(2, a, b), xi_2(a, b));
    
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