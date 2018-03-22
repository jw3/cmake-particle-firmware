include(ExternalProject)

set(TINYGPS_ID TinyGpsPlus)

externalproject_add(
        ${TINYGPS_ID}
        GIT_REPOSITORY https://github.com/mikalhart/TinyGPSPlus
        GIT_TAG master
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
        LOG_DOWNLOAD ON)

externalproject_get_property(${TINYGPS_ID} source_dir)
set(${TINYGPS_ID} "${source_dir}")

message(STATUS "[TinyGPS] APPLIBS=${${TINYGPS_ID}}")
