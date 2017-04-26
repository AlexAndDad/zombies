cmake_minimum_required(VERSION 3.6)

include("cmake/HunterGate.cmake")
include("cmake/all_functions.cmake")

HunterGate(
        URL "https://github.com/ruslo/hunter/archive/v0.18.43.tar.gz"
        SHA1 "d2c8c42cd07f7cefe18fd9a9b9c13114b1a15a27"
        LOCAL
)

project(zombies)

if (NOT "${CMAKE_CXX_STANDARD}")
    set(CMAKE_CXX_STANDARD 14)
endif ()

cmake_policy(VERSION 3.6)

add_executable(zombies src/main.cpp)



