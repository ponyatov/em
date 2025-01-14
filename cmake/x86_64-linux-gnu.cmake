set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)
set(TOOLCHAIN_PREFIX  ${ARCH}-${OS}-gnu)

include(cmake/any_toolchain.cmake)

add_compile_options(
    "-march=native"
)
