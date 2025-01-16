set(MCPU -march=armv7e-m   -mcpu=cortex-m4 )
set(MFPU -mfpu=fpv4-sp-d16 -mfloat-abi=hard)

add_compile_options( ${MCPU} ${MFPU} )
add_link_options   ( ${MCPU} ${MFPU} )

add_compile_definitions(
	USE_FULL_LL_DRIVER
	HSE_STARTUP_TIMEOUT=100
	LSE_STARTUP_TIMEOUT=5000
	EXTERNALSAI1_CLOCK_VALUE=2097000
	EXTERNALSAI2_CLOCK_VALUE=2097000
	INSTRUCTION_CACHE_ENABLE=1
	DATA_CACHE_ENABLE=1
    $<$<CONFIG:Debug>:DEBUG>
)
