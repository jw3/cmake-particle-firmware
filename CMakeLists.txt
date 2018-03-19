cmake_minimum_required(VERSION 3.0)
project(particle_cmake_cross_compile)

set(GCC_ARM_PATH /usr/local/gcc-arm/bin/)
set(FIRMWARE_DIR /usr/local/src/particle/firmware)
file(RELATIVE_PATH TARGET_DIR ${FIRMWARE_DIR}/main ${CMAKE_CURRENT_BINARY_DIR})

set(CMAKE_VERBOSE_MAKEFILE OFF)

set(MAKE_ARGS
    TARGET_DIR=${TARGET_DIR}
    GCC_ARM_PATH=${GCC_ARM_PATH}
    APPDIR=${CMAKE_CURRENT_SOURCE_DIR}/src)

add_custom_target(firmware
                  COMMAND make ${MAKE_ARGS}
                  WORKING_DIRECTORY ${FIRMWARE_DIR})
