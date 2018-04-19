include(ExternalProject)
set(LiquidCrystalI2C_Install lcdi2c)

externalproject_add(
${LiquidCrystalI2C_Install}
GIT_REPOSITORY https://github.com/BulldogLowell/LiquidCrystal_I2C_Spark.git
GIT_TAG master
CONFIGURE_COMMAND ""
BUILD_COMMAND ""
INSTALL_COMMAND ""
UPDATE_COMMAND ""
LOG_DOWNLOAD ON)

externalproject_get_property(${LiquidCrystalI2C_Install} source_dir)
set(LiquidCrystalI2C ${source_dir}/firmware)

set(SOURCE_FILES ${LiquidCrystalI2C}/LiquidCrystal_I2C_Spark.cpp)
if (NOT EXISTS ${SOURCE_FILES})
file(WRITE ${SOURCE_FILES})
endif ()

add_library(LiquidCrystalI2C OBJECT ${SOURCE_FILES})
target_include_directories(LiquidCrystalI2C PRIVATE ${LiquidCrystalI2C} ${PLATFORM_CXX_INCLUDES})
target_compile_options(LiquidCrystalI2C PRIVATE "$<$<CONFIG:ALL>:${PLATFORM_CXX_FLAGS}>")
target_compile_definitions(LiquidCrystalI2C PRIVATE ${PLATFORM_CXX_DEFS})
add_dependencies(LiquidCrystalI2C ${LiquidCrystalI2C_Install})
