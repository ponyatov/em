file(GLOB KSY
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.ksy
)

foreach(KSY_FILE ${KSY})
    string(REGEX REPLACE ".+\/(.+)\.ksy$" "${CMAKE_BINARY_DIR}/\\1.ksy.cpp"
        KSY_CPP             ${KSY_FILE})
        list(APPEND CP      ${KSY_CPP})
    string(REGEX REPLACE ".+\/(.+)\.ksy$" "\\1"
        KSY_PATH            ${KSY_FILE})
    add_custom_command(
        OUTPUT              ${KSY_CPP}
        DEPENDS             ${KSY_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             echo kaitai-struct-compiler
        ARGS                -- -I ${CMAKE_SOURCE_DIR}/src  -t cpp_stl
                            -d ${CMAKE_BINARY_DIR}/${KSY_PATH} ${KSY_FILE}
    )
endforeach()
