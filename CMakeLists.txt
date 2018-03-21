cmake_minimum_required(VERSION 3.0)
project(particle_cmake_cross_compile)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})
set(CMAKE_VERBOSE_MAKEFILE OFF)

if (NOT PLATFORM)
    set(PLATFORM photon)
endif ()

set(GCC_ARM_PATH /usr/local/gcc-arm/bin/)
set(FIRMWARE_DIR /usr/local/src/particle/firmware)

include(particle)
include(TinyGpsPlus)

add_particle_app(empty)
add_particle_app(tinker)
add_particle_app(blinker)

set(BUILD_DIR ${CMAKE_BINARY_DIR})
configure_file(common/flash.in ${CMAKE_BINARY_DIR}/flash)
