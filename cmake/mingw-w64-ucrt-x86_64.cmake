set(CMAKE_SYSTEM_NAME  Windows)
set(TOOLCHAIN_PREFIX   mingw-w64-ucrt-x86_64)

include(any_toolchain)

add_compile_options(
    "-march=native"
    "-mconsole"
)
