include(ExternalProject)
set(OneWire_Install onewire)

externalproject_add(
        ${OneWire_Install}
        GIT_REPOSITORY https://github.com/particle-iot/OneWireLibrary.git
        GIT_TAG master
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
        LOG_DOWNLOAD ON)

externalproject_get_property(${OneWire_Install} source_dir)
set(OneWire ${source_dir}/src)

set(SOURCE_FILES ${OneWire}/OneWire.cpp)
if (NOT EXISTS ${SOURCE_FILES})
    file(WRITE ${SOURCE_FILES})
endif ()

add_library(OneWire STATIC ${SOURCE_FILES})
target_include_directories(OneWire PRIVATE ${OneWire} ${PLATFORM_CXX_INCLUDES})
target_compile_options(OneWire PRIVATE "$<$<CONFIG:ALL>:${PLATFORM_CXX_FLAGS}>")
target_compile_definitions(OneWire PRIVATE ${PLATFORM_CXX_DEFS})
add_dependencies(OneWire ${OneWire_Install})
