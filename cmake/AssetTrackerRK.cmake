include(ExternalProject)
set(AssetTrackerRK_Install assettrackerrk)

include(LIS3DH)

externalproject_add(
        ${AssetTrackerRK_Install}
        GIT_REPOSITORY https://github.com/rickkas7/AssetTrackerRK.git
        GIT_TAG b913c5ac4967e83c466d8f079857ef349f8e7f69
        PATCH_COMMAND ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
        LOG_DOWNLOAD ON)

externalproject_get_property(${AssetTrackerRK_Install} source_dir)
set(AssetTrackerRK ${source_dir}/src)

set(SOURCE_FILES
    ${AssetTrackerRK}/TinyGPS++.cpp
    ${AssetTrackerRK}/AssetTrackerRK.cpp)

foreach (f IN ITEMS ${SOURCE_FILES})
    if (NOT EXISTS ${f})
        file(WRITE ${f})
    endif ()
endforeach ()

add_library(AssetTrackerRK STATIC ${SOURCE_FILES})
target_include_directories(AssetTrackerRK PRIVATE ${AssetTrackerRK} ${LIS3DH} ${PLATFORM_CXX_INCLUDES})
target_compile_options(AssetTrackerRK PRIVATE "$<$<CONFIG:ALL>:${PLATFORM_CXX_FLAGS}>")
target_compile_definitions(AssetTrackerRK PRIVATE ${PLATFORM_CXX_DEFS})
add_dependencies(AssetTrackerRK ${AssetTrackerRK_Install} LIS3DH)
