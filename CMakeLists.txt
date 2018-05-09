cmake_minimum_required(VERSION 3.0)
project(particle_cmake_cross_compile)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})
set(CMAKE_VERBOSE_MAKEFILE OFF)

set(BUILD_DIR ${CMAKE_BINARY_DIR})
set(GCC_ARM_PATH /usr/local/gcc-arm/bin/)
set(FIRMWARE_DIR /usr/local/src/particle/firmware)

if (NOT PLATFORM)
    message(WARNING "defaulting to photon platform, specify with PLATFORM")
    set(PLATFORM photon)
elseif (NOT PLATFORM MATCHES "^photon$|^electron$")
    message(FATAL_ERROR "invalid platform [${PLATFORM}] (choose 'photon' or 'electron')")
endif ()

message("
=============================== Configuring firmware for the -=-= ${PLATFORM} =-=- ===============================
")
include(${PLATFORM})

configure_file(common/flash.in ${CMAKE_BINARY_DIR}/flash)

include(particle)
include(TinyGpsPlus)
include(DS18B20)
include(LiquidCrystalI2C)
include(NeoGPS)

include(empty/CMakeLists.txt)
add_particle_remote_app(tinker)
add_particle_remote_app(blinker)
add_particle_remote_app(btserial)
add_particle_remote_app(knocker)
add_particle_remote_app(tracker TinyGpsPlus)
add_particle_remote_app(tracker2 NeoGPS)
add_particle_remote_app(display LiquidCrystalI2C)
add_particle_remote_app(thermometer OneWire DS18B20)
