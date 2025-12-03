string(TOUPPER ${HW} BOARD)

# CMakeLists.txt fragment for linker script generation
# set(LD "${CMAKE_BINARY_DIR}/gen/${BOARD}.ld")

message("-- |         board: " "${BOARD}")
message("-- | linker script: " "${LD}")
message("-- |")

# Find Python interpreter
find_package(Python3 REQUIRED)

# Define the linker script generation command
add_custom_command(
  OUTPUT  ${LD}
  COMMAND ${Python3_EXECUTABLE}
          ${CMAKE_SOURCE_DIR}/scripts/build_linker.py
          ${BOARD} ${LD} # --bootloader
  DEPENDS
    ${CMAKE_SOURCE_DIR}/cmake/espruino.cmake
    ${CMAKE_SOURCE_DIR}/scripts/build_linker.py
    ${CMAKE_SOURCE_DIR}/boards/${BOARD}.py
  COMMENT "Generating linker script for ${HW}"
  VERBATIM
)

# Create target that other targets can depend on
add_custom_target(
  linker_script
  DEPENDS ${LD}
)
