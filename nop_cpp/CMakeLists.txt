cmake_minimum_required(VERSION 2.8.3)

set(This nop_cpp)

project(${This} C CXX)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -Wall -o3")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

enable_testing()

add_subdirectory(
    include/googletest
)

include_directories(
    include
    lib
)

set(Headers
    include/nop_class.hpp

)
set(Sources
    lib/nop_class.cpp
#     app/nop_simple_test.cpp

)

add_library(${This} STATIC ${Sources} ${Headers})

add_subdirectory(
    test
)