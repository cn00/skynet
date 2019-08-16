include_directories(
        ${PROJECT_SOURCE_DIR}/3rd/lua
        ${PROJECT_SOURCE_DIR}/3rd/lua-md5
        ${PROJECT_SOURCE_DIR}/3rd/lpeg
)

#md5.so
file(GLOB_RECURSE md5_SRC 
        lua-md5/*.h
        lua-md5/*.c
)
add_library(md5 SHARED ${md5_SRC})
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} md5_SRC)
target_link_libraries(md5 ${SKYNET_LIB})

# lpeg.so
file(GLOB_RECURSE lpeg_SRC 
        lpeg/[^.]*.h
        lpeg/[^.]*.c
)
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} lpeg_SRC)
add_library(lpeg SHARED ${lpeg_SRC})
target_link_libraries(lpeg ${SKYNET_LIB})

# ffi
file(GLOB_RECURSE ffi_SRC 
        ffi/[^.]*.h
        ffi/[^.]*.c
)
source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} ffi_SRC)
add_library(ffi SHARED ${ffi_SRC})
target_link_libraries(ffi ${SKYNET_LIB})

