set(CMAKE_SYSTEM_NAME  Windows)
set(TOOLCHAIN_PREFIX   mingw-w64-ucrt-x86_64)

include(cmake/any_toolchain.cmake)

add_compile_options(
    "-march=native"
)
