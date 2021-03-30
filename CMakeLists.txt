cmake_minimum_required(VERSION 3.8)
project(skynet)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

# set(CMAKE_C_FLAGS  " -O2 -Wall -DNOUSE_JEMALLOC" )
set(CMAKE_C_FLAGS  " -Wall" )
set(CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} -dynamiclib -Wl,-undefined,dynamic_lookup -Wl, -DNOUSE_JEMALLOC -D__STDC_NO_ATOMICS__" )

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin) #set executable output path
set(LIBRARY_OUTPUT_PATH    ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_SHARED_LIBRARY_PREFIX "")

set(SKYNET_EXE "skynet")
set(SKYNET_LIB "libskynet")

macro(source_group_by_dir proj_dir source_files)
    if(MSVC OR APPLE)
        get_filename_component(sgbd_cur_dir ${proj_dir} ABSOLUTE)
        foreach(sgbd_file ${${source_files}})
			get_filename_component(sgbd_abs_file ${sgbd_file} ABSOLUTE)
            file(RELATIVE_PATH sgbd_fpath ${sgbd_cur_dir} ${sgbd_abs_file})
            string(REGEX REPLACE "\(.*\)/.*" \\1 sgbd_group_name ${sgbd_fpath})
            string(COMPARE EQUAL ${sgbd_fpath} ${sgbd_group_name} sgbd_nogroup)
            string(REPLACE "/" "\\" sgbd_group_name ${sgbd_group_name})
            if(sgbd_nogroup)
                set(sgbd_group_name "\\")
            endif(sgbd_nogroup)
            source_group(${sgbd_group_name} FILES ${sgbd_file})
        endforeach(sgbd_file)
    endif(MSVC OR APPLE)
endmacro(source_group_by_dir)

add_subdirectory(${PROJECT_SOURCE_DIR}/3rd)

# lua
file(GLOB_RECURSE lua_SRCS 
        ./*.lua
        app/null.c
)
add_library(luasrc ${lua_SRCS})
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} lua_SRCS)


# lua.so
add_subdirectory(${PROJECT_SOURCE_DIR}/3rd/lua)
add_subdirectory(${PROJECT_SOURCE_DIR}/3rd/luasocket)

# add_subdirectory(${PROJECT_SOURCE_DIR}/3rd/p7zip)
# add_subdirectory(${PROJECT_SOURCE_DIR}/3rd/lfb)

# add_subdirectory(${PROJECT_SOURCE_DIR}/3rd/jemalloc)

# gate.so harbor.so logger.so snlua.so
add_subdirectory(${PROJECT_SOURCE_DIR}/service-src)

# executabale myskynet
add_subdirectory(${PROJECT_SOURCE_DIR}/skynet-src)

# client.so  bson.so  md5.so  sproto.so  lpeg.so  skynet.so
add_subdirectory(${PROJECT_SOURCE_DIR}/lualib-src)

SET(CMAKE_INSTALL_PREFIX ".")

# message("DESTINATION ${EXECUTABLE_OUTPUT_PATH}/${CMAKE_BUILD_TYPE}")
# file(COPY examples app lualib service sharelua
#     DESTINATION ${EXECUTABLE_OUTPUT_PATH}/${CMAKE_BUILD_TYPE}
# )