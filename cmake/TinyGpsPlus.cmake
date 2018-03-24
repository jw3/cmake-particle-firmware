include(arm)
include(ExternalProject)

set(TinyGpsPlus_Install TinyGpsPlus_Install)

externalproject_add(
        ${TinyGpsPlus_Install}
        GIT_REPOSITORY https://github.com/mikalhart/TinyGPSPlus
        GIT_TAG master
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
        LOG_DOWNLOAD ON)

externalproject_get_property(${TinyGpsPlus_Install} source_dir binary_dir)
set(TinyGpsPlus ${source_dir}/src)
set(TINYGPS_INCLUDE ${source_dir}/src)

message(STATUS "${binary_dir}")
message(STATUS "[TinyGPS] APPLIBS=${TinyGpsPlus}")

add_library(TinyGpsPlus OBJECT ${TinyGpsPlus}/TinyGPS++.cpp)
target_compile_definitions(TinyGpsPlus PRIVATE ${ARM_DEFS})
add_dependencies(TinyGpsPlus TinyGpsPlus_Install)
