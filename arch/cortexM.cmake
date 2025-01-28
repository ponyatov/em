add_compile_options(
    -mthumb
    -DHSI_VALUE=8000000
    -DVDD_VALUE=3300
    -DUSE_FULL_LL_DRIVER
	-DHSE_STARTUP_TIMEOUT=100
	-DLSE_STARTUP_TIMEOUT=5000
)
add_link_options(
    -mthumb
    -lc -lm -lnosys
)
