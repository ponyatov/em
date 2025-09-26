# raw packets networking

# set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/lib/pcpp/lib/cmake/pcapplusplus")
# find_package(DPDK REQUIRED)

file(GLOB L
    RELATIVE ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/lib/pcpp/*.a
)
