Using CMake with Particle
===

Proof of concept Particle firmware build using CMake.

Active development based on CMake and the [Conan package manager](https://conan.io/) over in https://github.com/jw3/conan-particle

### goals

- Use CMake to build firmware
- Support third party library integration
- Do not use the particle cli application
- Be simple to setup and use
- Dont brick my boards
- Demonstrate integration with other dev tools
  - the JetBrains CLion IDE
  - the Conan package manager

### what was done

1. identify the build configuration used by the firmwasre makefiles
2. create a cmake build that uses that configuration
3. build the user app and its dependencies into .o files using cmake
4. modify the particle firmware build to allow injection of .o files
  - `USER_REMOTE` rather than `APPDIR`
5. build rest of firmware using the .o files rather than source files

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

### patching

The `patches` directory contains a patching pattern that integrates with cmake and allows for transparent patching of libs.

Patching may be useful when bringing in a arduino library, or perhaps if there is a bug in master, etc.

### development

> Currently, the 4.9-2015-q3-update is recommended. The 5.3.1 version can be used now and will be used for cloud compiles starting with system firmware 0.7.0. The 5.4.x and 6.x versions are not recommended at this time.

- https://docs.particle.io/faq/particle-tools/local-build/core/
- https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads

> By default, dfu-util requires sudo (root access) to run. This will cause a problem using the program-dfu option in make, and many other locations.

- https://docs.particle.io/faq/particle-tools/local-build/core/#install-dfu-util-linux

Add the particle rules from https://docs.particle.io/assets/files/50-particle.rules or they are also under `common`

> sudo cp 50-particle.rules /etc/udev/rules.d/

### credits

- tracker2 is an example from [NeoGPS](https://github.com/SlashDevin/NeoGPS)

### other

see the [notes](notes.md) for additional info
