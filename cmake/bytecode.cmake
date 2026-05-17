# precompiled bytecode

file(GLOB B
    RELATIVE ${CMAKE_SOURCE_DIR}
    bin/*.bcx
)

foreach(BCX_FILE ${B})
    string(REGEX REPLACE ".+\/(.+)\.bcx$" "${CMAKE_BINARY_DIR}/\\1.bcx.o"
        BCX_OBJECT          ${BCX_FILE})
    list(APPEND DATA        ${BCX_OBJECT})
    add_custom_command(
        OUTPUT              ${BCX_OBJECT}
        DEPENDS             ${BCX_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             objcopy
        ARGS                -I binary -O ${BCX_O} -B ${BCX_B} --rename-section .data=.bcx,alloc,load,data,contents --add-section .note.GNU-stack=/dev/null ${BCX_FILE} ${BCX_OBJECT}
    )
endforeach()
