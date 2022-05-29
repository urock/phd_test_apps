#include "nop_class.hpp"
#include <iostream>


float f1 (float n){
    std::cout<< "test test test test" << std::endl;
    return n;
};

NetOper::NetOper()
{
    m_unaryFuncMap[0] = f1;
}

float NetOper::getOperationResult(int operationNum, float input)
{
    return m_unaryFuncMap[operationNum](input);
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