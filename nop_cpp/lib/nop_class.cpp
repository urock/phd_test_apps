#include "nop_class.hpp"
#include "baseFunctions.hpp"
#include <iostream>


NetOper::NetOper()
{
    initUnaryFunctionsMap();
    initBinaryFunctionsMap();
}

void NetOper::solveRP(std::vector<float> goalDelta, std::vector<float> currentControl)
{
    // SetVs(delta_state_goal);
    // for i:=0 to L-1 do
    // case psi[i,i] of
    //   1,5..8: z[i]:=0;
    //   2: z[i]:=1;
    //   3: z[i]:=-infinity;
    //   4: z[i]:=infinity;
    // end;
    for(int i=0; i < m_MatrixDimension; ++i)
    {
        if (m_netOperMatrix[i][i] == 2)
            m_nodes[i] = 1;
        else if (m_netOperMatrix[i][i] == 3)
            m_nodes[i] = Infinity;
        else if (m_netOperMatrix[i][i] == 4)
            m_nodes[i] = (-1) * Infinity;
        else
            m_nodes[i] = 0;  
    }

    // for i:=0 to kP-1 do
    //     z[Pnum[i]]:=Vs[i];
    for(size_t i=0; i < m_nodesForVar.size(); ++i)
        m_nodes[m_nodesForVar[i]] = goalDelta[i];

    // for i:=0 to kR-1 do
    //     z[Rnum[i]]:=Cs[i];
    for (size_t i=0; i < m_nodesForParams.size(); ++i)
        m_nodes[m_nodesForParams[i]] = m_parameters[i];

    // for i:=0 to L-2 do
    //     for j:=i+1 to L-1 do
    //         if Psi[i,j]<>0 then
    //         begin
    //         case Psi[i,j] of
    float tmpVal; // zz
    for(size_t i=0; i < m_MatrixDimension - 1; ++i)
    {
        for(size_t j=0; j < m_MatrixDimension; ++j)
        {
            if (m_netOperMatrix[i][j] == 0)
                continue;
            tmpVal = getUnaryOperationResult(m_netOperMatrix[i][j], m_nodes[i]);

            m_nodes[j] = getBinaryOperationResult(m_netOperMatrix[j][j], m_nodes[j], tmpVal);

        }
    }

    for(size_t i = 0; i < m_nodesForOutput.size(); ++i)
        currentControl[i] = m_nodes[m_nodesForOutput[i]];


}

float NetOper::getUnaryOperationResult(int operationNum, float input)
{
    return m_unaryFuncMap[operationNum](input);
}

float NetOper::getBinaryOperationResult(int operationNum, float left, float right)
{
    return m_binaryFuncMap[operationNum](left, right);
}

void NetOper::initUnaryFunctionsMap()
{
    m_unaryFuncMap[1] = ro_1;
    m_unaryFuncMap[2] = ro_2;
    m_unaryFuncMap[3] = ro_3;
    m_unaryFuncMap[4] = ro_4;
    m_unaryFuncMap[5] = ro_5;
    m_unaryFuncMap[6] = ro_6;
    m_unaryFuncMap[7] = ro_7;
    m_unaryFuncMap[8] = ro_8;
    m_unaryFuncMap[9] = ro_9;
    m_unaryFuncMap[10] = ro_10;
    m_unaryFuncMap[11] = ro_11;
    m_unaryFuncMap[12] = ro_12;
    m_unaryFuncMap[13] = ro_13;
    m_unaryFuncMap[14] = ro_14;
    m_unaryFuncMap[15] = ro_15;
    m_unaryFuncMap[16] = ro_16;
    m_unaryFuncMap[17] = ro_17;
    m_unaryFuncMap[18] = ro_18;
    m_unaryFuncMap[19] = ro_19;
    m_unaryFuncMap[19] = ro_19;
    m_unaryFuncMap[20] = ro_20;
    m_unaryFuncMap[21] = ro_21;
    m_unaryFuncMap[22] = ro_22;
    m_unaryFuncMap[23] = ro_23;
    m_unaryFuncMap[24] = ro_24;
    m_unaryFuncMap[25] = ro_25;
    m_unaryFuncMap[26] = ro_26;
    m_unaryFuncMap[27] = ro_27;
    m_unaryFuncMap[28] = ro_28;
}

void NetOper::initBinaryFunctionsMap()
{
    m_binaryFuncMap[1] = xi_1;
    m_binaryFuncMap[2] = xi_2;
    m_binaryFuncMap[3] = xi_3;
    m_binaryFuncMap[4] = xi_4;
    m_binaryFuncMap[5] = xi_5;
    m_binaryFuncMap[6] = xi_6;
    m_binaryFuncMap[7] = xi_7;
    m_binaryFuncMap[8] = xi_8;
}


size_t NetOper::getMatrixDimension()
{
    return m_MatrixDimension;
}

void NetOper::setMatrixDimension(size_t newDim)
{
    if (newDim != m_MatrixDimension)
        m_MatrixDimension = newDim;
}

size_t NetOper::getOutputsNum()
{
    return m_numOutputs;
}

void NetOper::setOutputsNum(size_t newNum)
{
    if (newNum != m_numOutputs)
        m_numOutputs = newNum;
}