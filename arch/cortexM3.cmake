include(arch/cortexM.cmake)

set(MCPU -march=armv7-m -mcpu=cortex-m3)
set(FCPU -mfloat-abi=soft) # -mfpu=fpv4-sp-d16 )

add_compile_options(
    ${MCPU} ${MFPU}
)
add_compile_definitions(
    PREFETCH_ENABLE=1
    LSI_VALUE=40000
)
add_link_options(
    ${MCPU} ${MFPU}
)
