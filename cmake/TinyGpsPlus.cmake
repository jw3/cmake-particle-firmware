include(ExternalProject)
set(TinyGpsPlus_Install tinygps)

externalproject_add(
        ${TinyGpsPlus_Install}
        GIT_REPOSITORY https://github.com/codegardenllc/tiny_gps_plus.git
        GIT_TAG master
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
        LOG_DOWNLOAD ON)

externalproject_get_property(${TinyGpsPlus_Install} source_dir)
set(TinyGpsPlus ${source_dir}/firmware)

set(SOURCE_FILES ${TinyGpsPlus}/TinyGPS++.cpp)
if (NOT EXISTS ${SOURCE_FILES})
    file(WRITE ${SOURCE_FILES})
endif ()

add_library(TinyGpsPlus STATIC ${SOURCE_FILES})
target_include_directories(TinyGpsPlus PRIVATE ${TinyGpsPlus} ${PLATFORM_CXX_INCLUDES})
target_compile_options(TinyGpsPlus PRIVATE "$<$<CONFIG:ALL>:${PLATFORM_CXX_FLAGS}>")
target_compile_definitions(TinyGpsPlus PRIVATE ${PLATFORM_CXX_DEFS})
add_dependencies(TinyGpsPlus ${TinyGpsPlus_Install})
