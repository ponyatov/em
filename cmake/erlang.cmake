file(GLOB ERL
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/vm.erl
)

foreach(ERL_FILE ${ERL})
    string(REGEX REPLACE ".+\/(.+)\.erl$" "${CMAKE_SOURCE_DIR}/lib/\\1.S"
        SRL_FILE            ${ERL_FILE})
    string(REGEX REPLACE ".+\/(.+)\.erl$" "${CMAKE_SOURCE_DIR}/lib/\\1.e"
        XRL_FILE            ${ERL_FILE})
        list(APPEND BEAM    ${XRL_FILE})
    add_custom_command(
        OUTPUT              ${SRL_FILE}
        DEPENDS             ${ERL_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             erlc
        ARGS                -o ${CMAKE_SOURCE_DIR}/lib -S ${ERL_FILE}
    )
    add_custom_command(
        OUTPUT              ${XRL_FILE}
        DEPENDS             ${SRL_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             mv
        ARGS                ${SRL_FILE} ${XRL_FILE}
    )
endforeach()
