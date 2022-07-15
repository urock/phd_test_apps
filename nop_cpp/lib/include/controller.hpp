#pragma once

#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

#include "model.hpp"
#include "nop.hpp"

// class network operator
class Controller {

public:
  Controller(NetOper &netOper);

  /// RP from pascal version
  Model::Control calcControl(const Model::State &currState);


private:
  NetOper &m_netOper;
};
