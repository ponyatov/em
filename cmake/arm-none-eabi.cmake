set(CMAKE_SYSTEM_NAME      Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(TOOLCHAIN_PREFIX       arm-none-eabi)
set(CMAKE_CROSS_COMPILING  true)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

include(cmake/any_toolchain.cmake)

add_compile_options(
    -mthumb
    -ffunction-sections -fdata-sections
    -DCORTEX -D${SERIES}
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
#     $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
#     $<$<COMPILE_LANGUAGE:ASM>:-x$<SEMICOLON>assembler-with-cpp>
#     $<$<COMPILE_LANGUAGE:ASM>:-MMD>
#     $<$<COMPILE_LANGUAGE:ASM>:-MP>
)

add_link_options(
    -mthumb
    -T ${CMAKE_SOURCE_DIR}/hw/${HW}/${CPU_}x_FLASH.ld
    --specs=nano.specs
    -Wl,--start-group -lc -lm -Wl,--end-group
    -Wl,--start-group -lstdc++ -lsupc++ -Wl,--end-group
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections
    -Wl,--print-memory-usage
)

set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C   ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")
