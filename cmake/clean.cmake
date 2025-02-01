# add_custom_target(clean_all
#     COMMAND rm -rf
#         ${ELF} ${DFU}
#         ${CMAKE_INSTALL_PREFIX}/${CMAKE_PROJECT_NAME}*
#         ${CMAKE_BINARY_DIR}
#         ${TMP}/${CMAKE_PROJECT_NAME}*
#         ${TMP}/*.ragel.*
# )

set_property (
    TARGET ${CMAKE_PROJECT_NAME} APPEND
    PROPERTY ADDITIONAL_CLEAN_FILES
        ${CMAKE_INSTALL_PREFIX}/${BIN_OUTPUT_NAME} ${ELF} ${DFU}
)
