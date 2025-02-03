set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  x86_64)
set(TOOLCHAIN_PREFIX        ${ARCH}-${OS}-musl)

add_compile_options(
    "-march=native"
)

include(any_toolchain)

set(CMAKE_ASM_COMPILER  ${CMAKE_C_COMPILER})
set(CMAKE_LINKER        ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER  ${CMAKE_C_COMPILER})
