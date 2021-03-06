# Sets the minimum version of CMake required to build the native
# library. You should either keep the default value or only pass a
# value of 3.4.0 or lower.
# by huzongyao

cmake_minimum_required(VERSION 3.4.1)

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

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DANDROID_NDK -fexceptions -DNDEBUG -D_REENTRANT -DENV_UNIX")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DBREAK_HANDLER -DUNICODE -D_UNICODE -DUNIX_USE_WIN_FILE -fPIC")

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds it for you.
# Gradle automatically packages shared libraries with your APK.
file(GLOB_RECURSE NATIVE_SRCS 
    p7zip/*.h
    p7zip/*.c
    p7zip/*.cpp
    cmd/*.h
    cmd/*.cpp
    str2args/*.h
    str2args/*.cpp
)
message(stats "${NATIVE_SRCS}")

include_directories(
    ${PROJECT_SOURCE_DIR}/3rd/lua
    ./
    p7zip/CPP
    p7zip/CPP/Common
    p7zip/CPP/myWindows
    p7zip/CPP/include_windows
)
link_directories(${PROJECT_SOURCE_DIR}/3rd/lua)

source_group_by_dir(${CMAKE_CURRENT_SOURCE_DIR} NATIVE_SRCS)
add_library(p7zip SHARED ${NATIVE_SRCS})
target_link_libraries(p7zip ${SKYNET_LIB})

# add_executable(7z ${NATIVE_SRCS})
# target_link_libraries(7z)

if (APPLE)
	# find_library(lua lua)
	# find_library(ObjC objc)
	find_library(CoreFoundation CoreFoundation)
	# find_library(IOKit IOKit)
    target_link_libraries(p7zip 
        ${CoreFoundation} 
        # ${IOKit} 
        # ${ObjC}
        # ${lua}
    )

    # target_link_libraries(7z 
    #     ${CoreFoundation} 
    #     ${IOKit} 
    #     ${ObjC}
    # )
endif()

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in the
# build script, prebuilt third-party libraries, or system libraries.
# target_link_libraries(p7zip log)
