set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  armv7l)
set(TOOLCHAIN_PREFIX        arm-linux-gnueabihf)
set(CMAKE_EXECUTABLE_SUFFIX "")

include(any_toolchain)

add_compile_definitions(RPI ARMV7 LINUX)
add_compile_options()
add_link_options()
