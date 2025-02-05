include(arch/cortexM/cmake)

set(MCPU -march=armv7e-m   -mcpu=cortex-m4)
set(FCPU -mfpu=fpv4-sp-d16 -mfloat-abi=hard)

add_compile_options(
    ${MCPU} ${MFPU}
)

add_compile_definitions(
    PREFETCH_ENABLE=1
    INSTRUCTION_CACHE_ENABLE=1
    DATA_CACHE_ENABLE=1
)

add_link_options(
    ${MCPU} ${MFPU}
)
