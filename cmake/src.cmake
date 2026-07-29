# file(GLOB LD -> cmake/any_toolchain.cmake

file(GLOB_RECURSE S CONFIGURE_DEPENDS
    src/*.s
    # cross
    hw/${HW}/*.s
    hw/${HW}/src/*.s
    cpu/${CPU}/src/*.s
    arch/${ARCH}/src/*.s
    # lib
    lib/src/*.s lib/*/src/*.s
)

file(GLOB_RECURSE C CONFIGURE_DEPENDS
    src/*.c*
    # cross
      hw/src/*.c*   hw/${HW}/src/*.c*
     cpu/src/*.c*  cpu/${CPU}/src/*.c*
    arch/src/*.c* arch/${ARCH}/src/*.c*
      os/src/*.c*   os/${OS}/src/*.c*
    # lib
    lib/src/*.c* lib/*/src/*.c*
)

file(GLOB_RECURSE H CONFIGURE_DEPENDS
    inc/*.h*
    # cross
      hw/inc/*.h*   hw/${HW}/inc/*.h*
     cpu/inc/*.h*  cpu/${CPU}/inc/*.h*
    arch/inc/*.h* arch/${ARCH}/inc/*.h*
      os/inc/*.h*   os/${OS}/inc/*.h*
    # lib
    lib/inc/*.h* lib/*/inc/*.h*
)

file(GLOB_RECURSE INI CONFIGURE_DEPENDS lib/*.ini lib/*.? )

# include dirs
foreach(h ${H})
    get_filename_component(d ${h} DIRECTORY)
    list(APPEND INC ${d})
endforeach()
list(REMOVE_DUPLICATES INC)
include_directories(${CMAKE_CURRENT_BINARY_DIR} ${INC})

## depricated:

file(GLOB_RECURSE C
    # CortexM/CubeMX
    hw/${HW}/Core/Src/*.c*
    hw/${HW}/Drivers/*xx_HAL_Driver/Src/*.c*
    hw/${HW}/USB_DEVICE/App/*.c* hw/${HW}/USB_DEVICE/Target/*.c*
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/*.c*
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/*.c*
)

file(GLOB_RECURSE H
    # CortexM/CubeMX
    hw/${HW}/Core/Inc/*.h*
    hw/${HW}/Drivers/CMSIS/Include/*.h*
    hw/${HW}/Drivers/*xx_HAL_Driver/Inc/*.h*
    hw/${HW}/Drivers/CMSIS/Device/ST/*xx/Include/*.h*
    hw/${HW}/USB_DEVICE/App/*.h* hw/${HW}/USB_DEVICE/Target/*.h*
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Core/Inc/*.h*
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc/*.h*
    # net
    lib/pcpp/include/pcapplusplus/*.h*
)
