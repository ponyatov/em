set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  aarch64)
set(TOOLCHAIN_PREFIX        aarch64-linux-gnu)
set(CMAKE_EXECUTABLE_SUFFIX "")

include(any_toolchain)

add_compile_definitions(RPI AARCH64 LINUX)
add_compile_options()
add_link_options()
