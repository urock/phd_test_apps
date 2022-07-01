#include <cmath>
#include <gtest/gtest.h>

#include "nop.hpp"


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



TEST(NOP, setGetTest)
{
    auto netOper = NetOper();
    // for (auto n : {2,2,5,10,100})
    // {
    //     netOper.setOutputsNum(n);
    //     EXPECT_EQ(netOper.getOutputsNum(), n);
    // }    

    std::vector<int> nodesForVars = {0, 1, 2, 3};
    netOper.setNodesForVars(nodesForVars);
    EXPECT_TRUE(nodesForVars == netOper.getNodesForVars());    

    std::vector<int> nodesForParams = {2, 3, 4, 5};
    netOper.setNodesForParams(nodesForParams);
    EXPECT_TRUE(nodesForParams == netOper.getNodesForParams());    

    std::vector<int> nodesForOutput = {13, 13};
    netOper.setNodesForOutput(nodesForOutput);
    EXPECT_TRUE(nodesForOutput == netOper.getNodesForOutput());    

    std::vector<float> parameters = {0.1, 0.1};
    netOper.setCs(parameters);
    EXPECT_TRUE(parameters == netOper.getCs());    
}



TEST(NOP, setMatrixTest)
{
    auto netOper = NetOper();
    
    netOper.setPsi(NopPsiN);

    EXPECT_TRUE(NopPsiN == netOper.getPsi());
}


TEST(NOP, calcResultTest)
{   
    auto desiredFunction = [](std::vector<float> x,
                               std::vector<float> q)
    {
        return (pow(x[0], 2) - pow(x[1], 2)) * cos(q[0] * x[0] + q[1]) + x[0]*x[1]*exp(-q[2] * x[0]);
    };



    std::vector<float> parameters = {0.1, 0.1, 0.1};
    auto netOper = NetOper();
    // netOper.setOutputsNum(2);                // set Mout
    netOper.setNodesForVars({0, 1});         // Pnum
    netOper.setNodesForParams({2, 3, 4});    // Rnum
    netOper.setNodesForOutput({13, 13});     // Dnum
    netOper.setCs(parameters);              // set Cs

    netOper.setPsi(Psi);

    std::vector<float> x_in = {0.1, 0.2};

    auto expectedResult = desiredFunction(x_in, parameters);


    std::vector<float> y_out(2);
    netOper.calcResult(x_in, y_out);


    std::cout << "desiredFunction RESULT: " << expectedResult << std::endl;
    
    std::cout<<"RP RESULT: "<< y_out[0] <<" "<< y_out[1] << std::endl;

    EXPECT_TRUE(abs(y_out[0] - expectedResult) < 0.001);

}

