include(ExternalProject)
set(DS18B20_Install ds18b20)

include(OneWire)

externalproject_add(
        ${DS18B20_Install}
        GIT_REPOSITORY https://github.com/tomdeboer/SparkCoreDallasTemperature.git
        GIT_TAG master
        PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/apply.sh DS18B20
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        UPDATE_COMMAND ""
        LOG_DOWNLOAD ON)

externalproject_get_property(${DS18B20_Install} source_dir)
set(DS18B20 ${source_dir}/firmware)

file(WRITE ${DS18B20}/spark-dallas-temperature.cpp)

add_library(DS18B20 OBJECT ${DS18B20}/spark-dallas-temperature.cpp)
target_include_directories(DS18B20 PRIVATE ${DS18B20} ${OneWire} ${PLATFORM_CXX_INCLUDES})
target_compile_options(DS18B20 PRIVATE "$<$<CONFIG:ALL>:${PLATFORM_CXX_FLAGS}>")
target_compile_definitions(DS18B20 PRIVATE ${PLATFORM_CXX_DEFS})
add_dependencies(DS18B20 ${DS18B20_Install} OneWire)
