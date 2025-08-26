# precompiled bytecode

file(GLOB B
    RELATIVE ${CMAKE_SOURCE_DIR}
    tmp/*.bcx
)

foreach(BCX_FILE ${B})
    string(REGEX REPLACE ".+\/(.+)\.bcx$" "${CMAKE_BINARY_DIR}/\\1.bcx.o"
        BCX_OBJECT          ${BCX_FILE})
    list(APPEND BC          ${BCX_OBJECT})
    message(${BCX_FILE} "->" BCX_OBJECT)
    add_custom_command(
        OUTPUT              ${BCX_OBJECT}
        DEPENDS             ${BCX_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             objcopy
        ARGS                -I binary -O elf64-x86-64 -B i386:x86-64 --rename-section .data=.bcx,alloc,load,data,contents --add-section .note.GNU-stack=/dev/null ${BCX_FILE} ${BCX_OBJECT}
    )
endforeach()
