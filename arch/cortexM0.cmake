set(MCPU -march=armv6e-m   -mcpu=cortex-m0 )

add_compile_options( ${MCPU} ${MFPU} )
add_link_options   ( ${MCPU} ${MFPU} )
