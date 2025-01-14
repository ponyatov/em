cmake_minimum_required(VERSION 3.22)
get_filename_component(PROJECT_NAME ${CMAKE_SOURCE_DIR} NAME_WE)
project(${PROJECT_NAME} LANGUAGES C CXX ASM)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)
include(version)

set(CWD ${CMAKE_SOURCE_DIR})

file(GLOB_RECURSE LD
    "${CWD}/hw/${HW}/*.ld"
)
file(GLOB_RECURSE A
    "${CWD}/src/*.s*"
    "${CWD}/hw/${HW}/*.s"
)

