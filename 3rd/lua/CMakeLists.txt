

file(GLOB_RECURSE lua_SRCS 
        *.h
        *.c
)
include_directories(./../../skynet-src)

# set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/3rd/lua)

add_definitions(-DLUA_USE_LINUX -Wl, -ldl -lreadline)

source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} lua_SRCS)
add_library(lua SHARED ${lua_SRCS})
target_link_libraries(lua m readline)