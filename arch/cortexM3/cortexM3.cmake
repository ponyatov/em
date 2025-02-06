include(arch/cortexM/cortexM.cmake)

set(MCPU -march=armv7-m -mcpu=cortex-m3)
set(FCPU -mfloat-abi=soft) # -mfpu=fpv4-sp-d16 )

add_compile_options(
    ${MCPU} ${MFPU}
)

add_compile_definitions(
    HSI_VALUE=8000000
    LSI_VALUE=40000
    PREFETCH_ENABLE=1
    # INSTRUCTION_CACHE_ENABLE=1
    # DATA_CACHE_ENABLE=1
)

add_link_options(
    ${MCPU} ${MFPU}
)
