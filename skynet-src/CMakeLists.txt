set(TARGET_EXE ${SKYNET_EXE})

set(CMAKE_VERBOSE_MAKEFILE ON)#show compile command in console

# set(EXECUTABLE_OUTPUT_PATH  ${PROJECT_SOURCE_DIR})#set executable output path

include_directories(
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/skynet-src
        ${PROJECT_SOURCE_DIR}/3rd/jemalloc/include/jemalloc
)

#add_definitions(-Wl,-E)  #using add_definitions can't add "-WL,-E" ，it will cause that dlopen() return undefined symbol

link_directories(
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/3rd/jemalloc/lib
)

set(SKYNET_SRC
  ../skynet-exe/skynet_main.c 
)
file(GLOB_RECURSE SKYNET_SRC_H
        ./*.h
)
set (SKYNET_SRC ${SKYNET_SRC} ${SKYNET_SRC_H})
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} SKYNET_SRC)
add_executable(${TARGET_EXE} ${SKYNET_SRC})

target_link_libraries(${TARGET_EXE} ${SKYNET_LIB})
