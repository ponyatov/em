include(  hw/${HW}/${HW}.cmake    )
include( cpu/${CPU}/${CPU}.cmake  )
include(arch/${ARCH}/${ARCH}.cmake)
include(  os/${OS}/${OS}.cmake    )

string(TOUPPER ${HW}   HW_  )
string(TOUPPER ${CPU}  CPU_ )
string(TOUPPER ${ARCH} ARCH_)
string(TOUPPER ${OS}   OS_  )

set(ELF ${CMAKE_INSTALL_PREFIX}/${BIN_OUTPUT_NAME}.elf)
set(DFU ${CMAKE_INSTALL_PREFIX}/${BIN_OUTPUT_NAME}.dfu)

add_custom_command(
    OUTPUT  ${DFU}
    DEPENDS ${ELF}
    COMMAND ../elf2dfuse/bin/elf2dfuse ${ELF} ${DFU}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
add_custom_target(dfu DEPENDS ${DFU})

add_custom_target(firmware DEPENDS ${ELF}
    COMMAND openocd -f hw/${HW}/${HW}.ocd -c "program ${ELF} verify reset exit"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

add_custom_target(debug DEPENDS ${ELF}
    COMMAND openocd -f hw/${HW}/${HW}.ocd
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
