
include_directories(
        ${PROJECT_SOURCE_DIR}/skynet-src
        ${PROJECT_SOURCE_DIR}/3rd/lua
)
#
add_definitions(-fPIC)

add_library(snlua SHARED service_snlua.c)
target_link_libraries(snlua lua lualib)

add_library(logger SHARED service_logger.c)
target_link_libraries(logger lualib)

add_library(gate SHARED service_gate.c)
target_link_libraries(gate lualib)

add_library(harbor SHARED service_harbor.c)
target_link_libraries(harbor lualib)

