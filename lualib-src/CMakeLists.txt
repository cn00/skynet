
include_directories(
        ${PROJECT_SOURCE_DIR}/lualib-src
        ${PROJECT_SOURCE_DIR}/lualib-src/sproto
        ${PROJECT_SOURCE_DIR}/service-src
        ${PROJECT_SOURCE_DIR}/skynet-src
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/3rd/lua-md5
        ${PROJECT_SOURCE_DIR}/3rd/lpeg
)
add_definitions(-fPIC)

# skynet.so
file(GLOB_RECURSE lualib_SRC
        ./lsha1.c
        ./lua-*.h
        ./lua-*.c
        ../skynet-src/*.h
        ../skynet-src/*.c
)
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} lualib_SRC)

find_library(JEMALLOC_LIB jemalloc_pic ../3rd/jemalloc/lib)
IF(NOT JEMALLOC_LIB)
    message(FATAL_ERROR "jemalloc_pic not found")
ENDIF(NOT JEMALLOC_LIB)
message(STATUS "jemalloc_pic found in " ${JEMALLOC_LIB})

add_library(${SKYNET_LIB} SHARED ${lualib_SRC} )
target_link_libraries(${SKYNET_LIB} liblua pthread m dl)
target_link_libraries(${SKYNET_LIB} ${JEMALLOC_LIB})

#client.so
set(client_SRC 
        lua-clientsocket.c
        lua-crypt.c
        lsha1.c
)
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} client_SRC)
add_library(client SHARED ${client_SRC})
target_link_libraries(client ${SKYNET_LIB})

#bson.so
add_library(bson SHARED lua-bson.c )
target_link_libraries(bson ${SKYNET_LIB})


#sproto.so
file(GLOB_RECURSE sproto_SRC 
        sproto/*.h
        sproto/*.c
)
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} sproto_SRC)
add_library(sproto SHARED ${sproto_SRC})
target_link_libraries(sproto ${SKYNET_LIB})

