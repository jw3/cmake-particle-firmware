include(arm)
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

add_library(OneWire OBJECT ${OneWire}/OneWire.cpp)
target_include_directories(OneWire PRIVATE ${OneWire})
target_compile_definitions(OneWire PRIVATE ${ARM_DEFS} SPARK)
add_dependencies(OneWire ${OneWire_Install})
