find_package(Qt6 REQUIRED COMPONENTS Core Widgets)

if(Qt6_FOUND)
    list(APPEND LIBS Qt6::Core Qt6::Widgets)
endif()
