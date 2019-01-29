
file(GLOB_RECURSE SKYNET_SRC 
        ./*.h
        ./*.c
)
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} SKYNET_SRC)
set(CMAKE_VERBOSE_MAKEFILE ON)#show compile command in console

set(TARGET_EXE skynet)
# set(EXECUTABLE_OUTPUT_PATH  ${PROJECT_SOURCE_DIR})#set executable output path

include_directories(
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/skynet-src
        ${PROJECT_SOURCE_DIR}/3rd/jemalloc/include/jemalloc
)

#add_definitions(-Wl,-E)  #using add_definitions can't add "-WL,-E" ，it will cause that dlopen() return undefined symbol
set(CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} -Wl,-E -DNOUSE_JEMALLOC" )

link_directories(
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/3rd/jemalloc/lib
)

add_executable(${TARGET_EXE} ${SKYNET_SRC})
target_link_libraries(${TARGET_EXE} lualib)
