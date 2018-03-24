include(arm)
include(ExternalProject)

set(TinyGpsPlus_Install tinygps)

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
file(GLOB TINYGPS_SOURCE ${source_dir}/src/*.cpp)
message(STATUS "TinyGPS built in ${binary_dir}")

add_library(TinyGpsPlus OBJECT ${TINYGPS_SOURCE})
target_compile_definitions(TinyGpsPlus PRIVATE ${ARM_DEFS})
add_dependencies(TinyGpsPlus ${TinyGpsPlus_Install})
