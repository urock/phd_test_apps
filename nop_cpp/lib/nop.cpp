#include "nop_class.hpp"
#include "baseFunctions.hpp"
#include <iostream>


NetOper::NetOper()
{
    initUnaryFunctionsMap();
    initBinaryFunctionsMap();
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



size_t NetOper::getOutputsNum()
{
    return m_numOutputs;
}

void NetOper::setOutputsNum(size_t newNum)
{
    m_numOutputs = newNum;
}

const std::vector<int>& NetOper::getNodesForVars()
{
    return m_nodesForVars;
}

void NetOper::setNodesForVars(const std::vector<int>& nodes)
{
    m_nodesForVars = nodes;
}

const std::vector<int>& NetOper::getNodesForParams()
{
    return m_nodesForParams;
}

void NetOper::setNodesForParams(const std::vector<int>& nodes)
{
    m_nodesForParams = nodes;
}

const std::vector<int>& NetOper::getNodesForOutput()
{
    return m_nodesForOutput;
}

void NetOper::setNodesForOutput(const std::vector<int>& nodes)
{
    m_nodesForOutput = nodes;
}

const std::vector<std::vector<int>>& NetOper::getMatrix()
{
    return m_matrix;
}

const std::vector<float>& NetOper::getParameters()
{
    return m_parameters;
}

void NetOper::setParameters(const std::vector<float>& newParams)
{
    m_parameters = newParams;
}

void NetOper::setMatrix(const std::vector<std::vector<int>>& newMatrix)
{
    m_matrix = newMatrix;
    z.resize(m_matrix.size());
}

void NetOper::calcResult(const std::vector<float>& x_in, std::vector<float>& y_out)
{
    for(size_t i=0; i < m_matrix.size(); ++i)
    {
        if (m_matrix[i][i] == 2)
            z[i] = 1;
        else if (m_matrix[i][i] == 3)
            z[i] = (-1) * Infinity;
        else if (m_matrix[i][i] == 4)
            z[i] = Infinity;
        else
            z[i] = 0;  
    }

    for(size_t i=0; i < m_nodesForVars.size(); ++i)
        z[m_nodesForVars[i]] = x_in[i];

    for (size_t i=0; i < m_nodesForParams.size(); ++i)
        z[m_nodesForParams[i]] = m_parameters[i];

    for(size_t i=0; i < m_matrix.size() - 1; ++i)
    {
        for(size_t j=i+1; j < m_matrix.size(); ++j)
        {
            if (m_matrix[i][j] == 0)
                continue;
            auto zz = getUnaryOperationResult(m_matrix[i][j], z[i]);

            z[j] = getBinaryOperationResult(m_matrix[j][j], z[j], zz);

        }
    }

    for(size_t i = 0; i < m_nodesForOutput.size(); ++i)
        y_out[i] = z[m_nodesForOutput[i]];

}