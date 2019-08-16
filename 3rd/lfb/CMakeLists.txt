

file(GLOB_RECURSE lfb_SRCS 
        ./src/*.h
        ./src/*.hpp
        ./src/*.cpp
)
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} lfb_SRCS)
include_directories(
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/3rd/lfb
        ${PROJECT_SOURCE_DIR}/3rd/lfb/src
        ${PROJECT_SOURCE_DIR}/3rd/lfb/src/flatbuffers
        ${PROJECT_SOURCE_DIR}/3rd/lfb/src/flatbuffers/include
)

add_library(lfb SHARED ${lfb_SRCS})
target_link_libraries(lfb ${SKYNET_LIB})
