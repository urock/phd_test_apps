cmake_minimum_required(VERSION 2.8.3)
project(nop_cpp)

add_compile_options(-g -Wall -static -O3)

# include_directories(
#         driver
#         api
# )

# SET(CMAKE_EXE_LINKER_FLAGS "-static")

# add_library(pcie_api STATIC api/locate.c api/power.c api/driver-api.c)

add_executable(nop_simple_test app/nop_simple_test.cpp)
