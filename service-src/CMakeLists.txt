
include_directories(
        ${PROJECT_SOURCE_DIR}/skynet-src
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/lualib-src
        ${PROJECT_SOURCE_DIR}/lualib-src/sproto
        ${PROJECT_SOURCE_DIR}/service-src
        ${PROJECT_SOURCE_DIR}/skynet-src
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/3rd/lua-md5
        ${PROJECT_SOURCE_DIR}/3rd/lpeg
)
#
add_definitions(-fPIC)

add_library(snlua SHARED service_snlua.c)
target_link_libraries(snlua lua ${SKYNET_LIB})

add_library(logger SHARED service_logger.c)
target_link_libraries(logger ${SKYNET_LIB})

add_library(gate SHARED service_gate.c)
target_link_libraries(gate ${SKYNET_LIB})

add_library(harbor SHARED service_harbor.c)
target_link_libraries(harbor ${SKYNET_LIB})

