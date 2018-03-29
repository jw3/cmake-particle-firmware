Example CMake Cross Compile Particle Firmware
===

An example of using CMake to build firmware for particle devices.

### goals

- use cmake to build firmware
- use clion as an ide
- support third party library integration
- do not install the particle cli
- be simple to setup and use
- dont brick my boards

### hacking references

- https://github.com/particle-iot/firmware/blob/develop/docs/build.md
- https://github.com/particle-iot/firmware/blob/v0.6.4/build/module.mk
- https://github.com/particle-iot/firmware/blob/develop/user/src/application.cpp
- https://github.com/particle-iot/firmware/blob/develop/docs/build.md#external_libs
- https://github.com/particle-iot/firmware/blob/develop/docs/build.md#custom-makefile
- https://github.com/particle-iot/firmware/tree/v0.6.4/user/tests/libraries/unit-test


### development

particle calls for

- https://docs.particle.io/faq/particle-tools/local-build/core/
- https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads

> Currently, the 4.9-2015-q3-update is recommended. The 5.3.1 version can be used now and will be used for cloud compiles starting with system firmware 0.7.0. The 5.4.x and 6.x versions are not recommended at this time.

- https://docs.particle.io/faq/particle-tools/local-build/core/#install-dfu-util-linux

> By default, dfu-util requires sudo (root access) to run. This will cause a problem using the program-dfu option in make, and many other locations.

Add the particle rules from https://docs.particle.io/assets/files/50-particle.rules

> sudo cp 50-particle.rules /etc/udev/rules.d/

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

### related

- https://github.com/jw3/stegratxr-dancer
