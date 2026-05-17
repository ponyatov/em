set(CMAKE_SYSTEM_NAME       Windows)
set(CMAKE_SYSTEM_PROCESSOR  i5)
set(TOOLCHAIN_PREFIX        mingw-w64-ucrt-x86_64)
set(CMAKE_EXECUTABLE_SUFFIX ".exe")

include(any_toolchain)

add_compile_definitions(I5 WIN64)
add_compile_options(
    "-march=native"
    "-mconsole"
)
add_link_options()
