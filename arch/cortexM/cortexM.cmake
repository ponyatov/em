add_compile_options(
    -mthumb
)

add_compile_definitions(
	USE_FULL_LL_DRIVER
	HSE_STARTUP_TIMEOUT=100
	LSE_STARTUP_TIMEOUT=5000
	LSE_VALUE=32768
	VDD_VALUE=3300
)
