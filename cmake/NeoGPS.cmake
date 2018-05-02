include(ExternalProject)
set(NeoGPS_Install neogps)

# using v4.1.3 as the particle cloud does
externalproject_add(
        ${NeoGPS_Install}
        GIT_REPOSITORY https://github.com/SlashDevin/NeoGPS.git
        GIT_TAG v4.1.3
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
        LOG_DOWNLOAD ON)

externalproject_get_property(${NeoGPS_Install} source_dir)

set(NeoGPS ${source_dir}/src)
set(SOURCE_FILES
    ${NeoGPS}/DMS.cpp
    ${NeoGPS}/GPSTime.cpp
    ${NeoGPS}/Location.cpp
    ${NeoGPS}/NeoTime.cpp
    ${NeoGPS}/NMEAGPS.cpp
    ${NeoGPS}/Streamers.cpp
    ${NeoGPS}/ublox/ubxGPS.cpp
    ${NeoGPS}/ublox/ubxmsg.cpp
    ${NeoGPS}/ublox/ubxNMEA.cpp)

foreach (f IN ITEMS ${SOURCE_FILES})
    if (NOT EXISTS ${f})
        file(WRITE ${f})
    endif ()
endforeach ()

add_library(NeoGPS STATIC ${SOURCE_FILES})
target_include_directories(NeoGPS PRIVATE ${NeoGPS} ${PLATFORM_CXX_INCLUDES})
target_compile_options(NeoGPS PRIVATE "$<$<CONFIG:ALL>:${PLATFORM_CXX_FLAGS}>")
target_compile_definitions(NeoGPS PRIVATE ${PLATFORM_CXX_DEFS})
set_target_properties(NeoGPS PROPERTIES LINKER_LANGUAGE CXX)
add_dependencies(NeoGPS ${NeoGPS_Install})
