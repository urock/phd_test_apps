cmake_minimum_required(VERSION 2.8.3)

set(This nop_tests)

set(Sources
    nop_class_test.cpp
    nop_controller_test.cpp
)

add_executable(${This} ${Sources})

target_link_libraries( ${This} PUBLIC
    gtest_main
    nop_cpp
)

add_test(
    NAME ${This}
    COMMAND ${This}
)
