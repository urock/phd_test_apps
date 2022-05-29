#pragma once

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
    
    size_t getMatrixDimension();
    size_t getOutputsNum();

    void setMatrixDimension(size_t newDim);
    void setOutputsNum(size_t newNum);

private:
    size_t m_MatrixDimension;              // L
    size_t m_numOutputs;                   // Mout
    std::vector<float> m_variables;        // Vs
    std::vector<float> m_parameters;       // Cs
    std::vector<int> m_unaryOperations;    // O1s
    std::vector<int> m_binaryOperations;   // O2s
    std::vector<int> m_nodesForVar;        // Pnum
    std::vector<int> m_nodesForParams;     // Rnum
    std::vector<int> m_nodesForOutput;     // Dnum
    std::vector<float> m_nodes;            // z
    std::vector<std::string> m_nodesExpr;  // zs

    std::vector<std::vector<int>> m_netOperMatrix; // Psi

    // std::vector<std::vector<int>> m_netOperMatrix0 // Psi0

};