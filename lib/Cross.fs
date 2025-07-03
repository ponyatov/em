let pc: unit = //
    mkdir "hw/pc"
    touch "hw/pc/pc.mk"
    touch "hw/pc/pc.cmake"
    mkdir "hw/pc/inc"
    mkdir "hw/pc/src"
    touch "hw/pc/inc/pc.hpp"
    touch "hw/pc/src/pc.cpp"

let f429disco: unit = //
    mkdir "hw/f429disco"
    touch "hw/f429disco/f429disco.mk"
    touch "hw/f429disco/f429disco.cmake"
    mkdir "hw/f429disco/inc"
    mkdir "hw/f429disco/src"
    touch "hw/f429disco/inc/f429disco.hpp"
    touch "hw/f429disco/src/f429disco.cpp"

let pillf103: unit = //
    mkdir "hw/pillf103"
    touch "hw/pillf103/pillf103.mk"
    touch "hw/pillf103/pillf103.cmake"
    mkdir "hw/pillf103/inc"
    mkdir "hw/pillf103/src"
    touch "hw/pillf103/inc/pillf103.hpp"
    touch "hw/pillf103/src/pillf103.cpp"

let hw: unit = //
    mkdir "hw"
    mkdir "hw/inc"
    mkdir "hw/src"
    pc
    f429disco
    pillf103

let i5: unit = //
    mkdir "cpu/i5"
    touch "cpu/i5/i5.mk"
    touch "cpu/i5/i5.cmake"
    mkdir "cpu/i5/inc"
    mkdir "cpu/i5/src"
    touch "cpu/i5/inc/i5.hpp"
    touch "cpu/i5/src/i5.cpp"

let cpu: unit = //
    mkdir "cpu"
    mkdir "cpu/inc"
    mkdir "cpu/src"
    i5

let x86_64: unit = //
    mkdir "arch/x86_64"
    touch "arch/x86_64/x86_64.mk"
    touch "arch/x86_64/x86_64.cmake"
    mkdir "arch/x86_64/inc"
    mkdir "arch/x86_64/src"
    touch "arch/x86_64/inc/x86_64.hpp"
    touch "arch/x86_64/src/x86_64.cpp"

let arch: unit = //
    mkdir "arch"
    mkdir "arch/inc"
    mkdir "arch/src"
    x86_64

let none: unit = //
    mkdir "os/none"
    touch "os/none/none.mk"
    touch "os/none/none.cmake"
    mkdir "os/none/inc"
    mkdir "os/none/src"
    touch "os/none/inc/none.hpp"
    touch "os/none/src/none.cpp"

let freertos: unit = //
    mkdir "os/freertos"
    touch "os/freertos/freertos.mk"
    touch "os/freertos/freertos.cmake"
    mkdir "os/freertos/inc"
    mkdir "os/freertos/src"
    touch "os/freertos/inc/freertos.hpp"
    touch "os/freertos/src/freertos.cpp"

let linux: unit = //
    mkdir "os/linux"
    touch "os/linux/linux.mk"
    touch "os/linux/linux.cmake"
    mkdir "os/linux/inc"
    mkdir "os/linux/src"
    touch "os/linux/inc/linux.hpp"
    touch "os/linux/src/linux.cpp"

let os: unit = //
    mkdir "os"
    mkdir "os/inc"
    mkdir "os/src"
    none
    freertos
    linux

let cross: unit = //
    hw
    cpu
    arch
    os
