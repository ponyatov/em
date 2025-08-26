set(CMAKE_SYSTEM_NAME  Windows)
set(TOOLCHAIN_PREFIX   i686-w64-mingw32)

include(any_toolchain)

add_compile_options(
    "-march=i686 -mtune=i686"
    "-mconsole"
)
