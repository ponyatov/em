file(GLOB WAT
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.wat
)

foreach(WAT_FILE ${WAT})
    string(REGEX REPLACE ".+\/(.+)\.wat$" "${CMAKE_SOURCE_DIR}/bin/\\1.wasm"
        WASM_FILE           ${WAT_FILE})
        list(APPEND WASM    ${WASM_FILE})
    add_custom_command(
        OUTPUT              ${WASM_FILE}
        DEPENDS             ${WAT_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             wat2wasm
        ARGS                ${WAT_FILE} -o ${WASM_FILE}
    )
endforeach()

foreach(WASM_FILE ${WASM})
    string(REGEX REPLACE ".+\/(.+)\.wasm$" "${CMAKE_SOURCE_DIR}/tmp/\\1.wat"
        WASM_WAT            ${WASM_FILE})
        list(APPEND WASM    ${WASM_WAT})
    add_custom_command(
        OUTPUT              ${WASM_WAT}
        DEPENDS             ${WASM_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             wasm2wat
        ARGS                ${WASM_FILE} -o ${WASM_WAT}
    )
endforeach()

add_custom_target(wasm DEPENDS ${WASD} ${CP} ${HP})
