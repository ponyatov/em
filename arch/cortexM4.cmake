
set(MCPU -mcpu=cortex-m4)
set(MFPU -mfpu=fpv4-sp-d16 -mfloat-abi=hard)

add_compile_options( ${MCPU} ${MFPU} )
add_link_options   ( ${MCPU} ${MFPU} )
