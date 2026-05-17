# sudo apt install linux-headers-$(uname -r) kmod kbuild dkms

# execute_process(
#     OUTPUT_VARIABLE UNAMER
#     COMMAND uname -r
#     WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
#     OUTPUT_STRIP_TRAILING_WHITESPACE
# )

file(GLOB KC
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/kmod/*.c*
)

foreach(K ${KC})
    string(REGEX REPLACE ".+\/(.+)\.c$" "${CMAKE_SOURCE_DIR}/src/kmod/\\1.ko"
        KO                  ${K})
    list(APPEND KMOD        ${KO})
    add_custom_command(
        OUTPUT              ${KO}
        DEPENDS             ${K}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}/src/kmod
        COMMAND             make
    )
endforeach()
