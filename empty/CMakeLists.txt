set(CMAKE_CXX_COMPILER /usr/local/gcc-arm/bin/arm-none-eabi-g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g3 -gdwarf-2 -Os -mcpu=cortex-m3 -mthumb")

add_library(empty_ide STATIC application.cpp)
target_compile_definitions(empty_ide PRIVATE ARDUINO=10800 RELEASE_BUILD)

add_particle_app(empty)
add_dependencies(empty empty_ide)
