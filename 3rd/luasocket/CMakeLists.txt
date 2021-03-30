

file(GLOB_RECURSE luasocket_SRCS 
        *.h
        *.c
)
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
# set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/3rd/lua)

add_definitions(-DLUA_USE_LINUX -Wl,-E -ldl -lreadline)

source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} luasocket_SRCS)
add_library(socket SHARED ${luasocket_SRCS})
target_link_libraries(socket liblua)
