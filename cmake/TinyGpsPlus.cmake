include(ExternalProject)

set(TINYGPS_INSTALL tinygps)
set(TINYGPS_LIBRARY libtinygps)

externalproject_add(
        ${TINYGPS_INSTALL}
        GIT_REPOSITORY https://github.com/jw3/TinyGPSPlus
        GIT_TAG cmake
        LOG_DOWNLOAD ON
        LOG_CONFIGURE ON
        LOG_BUILD ON)

externalproject_get_property(${TINYGPS_INSTALL} source_dir binary_dir)
message(STATUS "TinyGPS: ${source_dir} / ${binary_dir}")

set(TINYGPS_INCLUDES "${source_dir}/src")
set(TINYGPS_LIBRARY_PATH ${binary_dir}/src/${CMAKE_FIND_LIBRARY_PREFIXES}tiny.a)

add_library(${TINYGPS_LIBRARY} UNKNOWN IMPORTED)
add_dependencies(${TINYGPS_LIBRARY} ${TINYGPS_INSTALL})

set_target_properties(${TINYGPS_LIBRARY} PROPERTIES
                      IMPORTED_LOCATION ${TINYGPS_LIBRARY_PATH})
