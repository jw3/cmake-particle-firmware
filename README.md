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

### status

As of 04/2018 using this without issue to flash photons and electrons while working exclusively out of JetBrains CLion without any connection to cloud.

Development flow in CLion is typical to what you would expect in a CMake project.

The flashing app works well, the python tweaks seem to have eliminated all misfires.

Have not bricked any boards.  Still want to test what happens if a board is flashed when specifying the wrong platform...

Working on repository and patterns for sharing CMake modules for particle libraries; https://github.com/jw3/particle-cmakes

Conan integration is on the radar but nothing planned yet.

### building

The `build.sh` script requires a single parameter that identifies the platform

`build.sh photon`

Only `photon` or `electron` are acceptable values.

An additional parameter can be passed to perform a quick build (dont delete previous compilation)

'build.sh photon quick'

### flashing

Do so at your own risk!

- `flash <app> <connection>`

Currently the only supported connection is `usb`.

Example: `flash tinker usb`

If running from the flash script in the root of the source dir you must provide the build directory:

`BUILD_DIR=build flash tinker usb`

This then uses the build configured flash script in the root of the build directory.

The flasher script is setup to use auto dfu mode.  Its hardcoded as this for now

```
PARTICLE_SERIAL_DEV = /dev/ttyACM0
START_DFU_FLASHER_SERIAL_SPEED = 14400
```

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

### notes

- successfully flashed both photon and electron with multiple firmwares
  - sanity checked round trips after flashing using the tinker mobile app
- targets must be compiled sequentially at this time (ie. `-j1`)
- patched firmware repository to enabled remote user module
  - https://github.com/jw3/firmware/tree/0.6.4-user_remote
- to use nested cmake directories use include
  - do `include(dir/CMakeLists.txt)`
  - dont `add_subdirectory(dir)`

### related works

- https://github.com/jw3/stegratxr-dancer
- https://github.com/jw3/firmware/tree/0.6.4-user_remote
