include(ExternalProject)
set(LIS3DH_Install lis3dh)

externalproject_add(
        ${LIS3DH_Install}
        GIT_REPOSITORY https://github.com/rickkas7/LIS3DH.git
        GIT_TAG 8d8f331dd6cfce93380de2988693832a3397f03e
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
        LOG_DOWNLOAD ON)

externalproject_get_property(${LIS3DH_Install} source_dir)
set(LIS3DH ${source_dir}/src)

set(SOURCE_FILES ${LIS3DH}/LIS3DH.cpp)
if (NOT EXISTS ${SOURCE_FILES})
    file(WRITE ${SOURCE_FILES})
endif ()

add_library(LIS3DH STATIC ${SOURCE_FILES})
target_include_directories(LIS3DH PRIVATE ${LIS3DH} ${PLATFORM_CXX_INCLUDES})
target_compile_options(LIS3DH PRIVATE "$<$<CONFIG:ALL>:${PLATFORM_CXX_FLAGS}>")
target_compile_definitions(LIS3DH PRIVATE ${PLATFORM_CXX_DEFS})
add_dependencies(LIS3DH ${LIS3DH_Install})
