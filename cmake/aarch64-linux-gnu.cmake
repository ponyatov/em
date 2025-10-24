set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  aarch64)
set(TOOLCHAIN_PREFIX        ${ARCH}-${OS}-gnu)
set(CMAKE_EXECUTABLE_SUFFIX "")

include(any_toolchain)

add_compile_definitions(AARCH64 RPI LINUX)
add_compile_options()
add_link_options()
