include(FindPackageHandleStandardArgs)

# find_package(PkgConfig REQUIRED)
# pkg_check_modules(RAGEL REQUIRED ragel)

if(NOT RAGEL_EXECUTABLE)
find_program(RAGEL_EXECUTABLE ragel)
message(STATUS "Looking for ragel")
endif()

if(RAGEL_EXECUTABLE)
    execute_process(
            COMMAND "${RAGEL_EXECUTABLE}" -v
            OUTPUT_VARIABLE _version_output
            RESULT_VARIABLE _version_result
            OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    if(_version_result EQUAL 0)
        string(REGEX MATCH "[0-9]+\\.[0-9]+(\\.[0-9]+)*" RAGEL_VERSION "${_version_output}")
        set(RAGEL_FOUND TRUE)
        message("-- | RAGEL: " ${RAGEL_VERSION})
    endif()
endif()

if(RAGEL_EXECUTABLE)
file(GLOB R
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.ragel
    lib/src/*.ragel lib/*/src/*.ragel
)
endif()

if(RAGEL_EXECUTABLE)
foreach(RAGEL_FILE ${R})
    string(REGEX REPLACE ".+\/(.+)\.ragel$" "${CMAKE_BINARY_DIR}/\\1.ragel.cpp"
        RAGEL_CPP           ${RAGEL_FILE})
    list(APPEND CP          ${RAGEL_CPP})
    add_custom_command(
        OUTPUT              ${RAGEL_CPP}
        DEPENDS             ${RAGEL_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${RAGEL_EXECUTABLE}
        ARGS                -C -G2 -o ${RAGEL_CPP} ${RAGEL_FILE}
    )
endforeach()
endif()
