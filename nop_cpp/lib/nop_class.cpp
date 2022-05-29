#include "nop_class.hpp"
#include <iostream>

NetOper::NetOper()
{

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