add_compile_definitions(
    F429DISCO DATA_IN_ExtSDRAM USE_STM32F429I_DISCO
)

add_compile_options(
    -UI2C_ENABLED -UUSB -USD_CARD
)
