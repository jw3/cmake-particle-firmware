Example CMake Cross Compile Particle Firmware
===

An example of using CMake to build firmware for particle devices.

### references

- https://github.com/particle-iot/firmware/blob/develop/docs/build.md
- https://github.com/particle-iot/firmware/blob/v0.6.4/build/module.mk
- https://github.com/particle-iot/firmware/blob/develop/user/src/application.cpp
- https://github.com/particle-iot/firmware/blob/develop/docs/build.md#external_libs
- https://github.com/particle-iot/firmware/blob/develop/docs/build.md#custom-makefile
- https://github.com/particle-iot/firmware/tree/v0.6.4/user/tests/libraries/unit-test

### udev rules

- https://gist.github.com/monkbroc/b283bb4da8c10228a61e

### flashing

Do so at your own risk!

- `flash <app> <connection>`

Currently the only supported connection is `usb`.

Example: `flash tinker usb`

If running from the flash script in the root of the source dir you must provide the build directory:

`BUILD_DIR=build flash tinker usb`

This then uses the build configured flash script in the root of the build directory.

### note

- targets must be compiled sequentially at this time (ie. `-j1`)
- patched firmware repository to enabled remote user module here https://github.com/jw3/firmware/tree/0.6.4-user_remote
- to use nested cmake directories `include(dir/CMakeLists.txt)`, not `add_subdirectory(dir)`
