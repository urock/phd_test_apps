#pragma once

#include "baseFunctions.hpp"
#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>


// class network operator
class NetOper
{
public:
    NetOper();

    // RPCntrol
    void solveRP(const std::vector<float>& goalDelta, std::vector<float>& currentControl);

    float getUnaryOperationResult(int operationNum, float input);
    float getBinaryOperationResult(int operationNum, float left, float right);
    
/*    void setMatrixDimension(size_t newDim);
    size_t getMatrixDimension();*/
    
    void setOutputsNum(size_t newNum);
    size_t getOutputsNum();

    // TODO use move semantics and rvalues
    void setNodesForVars(const std::vector<int>& nodes);
    const std::vector<int>& getNodesForVars();

    void setNodesForParams(const std::vector<int>& nodes);
    const std::vector<int>& getNodesForParams();

    void setNodesForOutput(const std::vector<int>& nodes);
    const std::vector<int>& getNodesForOutput();

    void setParameters(const std::vector<float>& newParams);
    const std::vector<float>& getParameters();

    void setMatrix(const std::vector<std::vector<int>>& newMatrix);
    const std::vector<std::vector<int>>& getMatrix();

    
private:
    void initUnaryFunctionsMap();
    void initBinaryFunctionsMap();

private:
    // size_t m_matrixDimension;              // L
    size_t m_numOutputs;                   // Mout
    std::vector<float> m_variables;        // Vs // probably useless
    std::vector<float> m_parameters;       // Cs
    std::vector<int> m_unaryOperations;    // O1s
    std::vector<int> m_binaryOperations;   // O2s
    std::vector<int> m_nodesForVars;       // Pnum
    std::vector<int> m_nodesForParams;     // Rnum
    std::vector<int> m_nodesForOutput;     // Dnum
    std::vector<float> m_nodes;            // z
    std::vector<std::string> m_nodesExpr;  // zs

    std::vector<std::vector<int>> m_matrix; // Psi

    std::map<int, float(*)(float)> m_unaryFuncMap;
    std::map<int, float(*)(float, float)> m_binaryFuncMap;



};