### status

As of 04/2018 using this without issue to flash photons and electrons while working exclusively out of JetBrains CLion without any connection to cloud.

Development flow in CLion is typical to what you would expect in a CMake project.

The flashing app works well, the python tweaks seem to have eliminated all misfires.

Have not bricked any boards.  Still want to test what happens if a board is flashed when specifying the wrong platform...

Working on repository and patterns for sharing CMake modules for particle libraries; https://github.com/jw3/particle-cmakes

Conan integration is on the radar but nothing planned yet.

### extracting parameters

Build an application normally from the command line, like

`APPDIR=$HOME/cmake-particle-firmware/tinker make PLATFORM=photon > photon.log`

Setting `APPDIR` to the location of the user code and `PLATFORM` to supported platform is enough.

If the particle firmware was not compiled beforehand then there will be extra output in the log, run again for a concise view of the user part.

The first compilation unit will be for the user code and contain the flags needed.  The steps after that we continue to outsource to the standard build.

### hacking references

- https://github.com/particle-iot/firmware/blob/develop/docs/build.md
- https://github.com/particle-iot/firmware/blob/v0.6.4/build/module.mk
- https://github.com/particle-iot/firmware/blob/develop/user/src/application.cpp
- https://github.com/particle-iot/firmware/blob/develop/docs/build.md#external_libs
- https://github.com/particle-iot/firmware/blob/develop/docs/build.md#custom-makefile
- https://github.com/particle-iot/firmware/tree/v0.6.4/user/tests/libraries/unit-test

#### errors
- 'bytecode stream generated with LTO version 4.0 instead of the expected 3.0'
  - the firmware was built with different gcc than is being used to compile the app
  - ran into this switching between 4.9 and 5.3
- firmware 0.7.0
  - `MODULE_FUNCTION" is not defined`
  - https://github.com/particle-iot/firmware/issues/1368
- 'build.mk:65: *** "No sources found in /tmp/.mount_jetbraUvOxBx/".  Stop.'
  - when compiling firmware 0.7.0 from clion console
  - use a non-clion console and builds fine

### downloads
- [gcc arm 4.9](https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2)
- [gcc arm 5.3](https://developer.arm.com/-/media/Files/downloads/gnu-rm/5_3-2016q1/gccarmnoneeabi532016q120160330linuxtar.bz2)

### udev rules

- https://gist.github.com/monkbroc/b283bb4da8c10228a61e

### system firmware updates

currently using manual process described [here](https://docs.particle.io/support/troubleshooting/firmware-upgrades/electron/#manual-firmware-update), including downloading the firmware binaries from the github releases.

going into safe mode immediately after establishing connection is a symptom of mismatched firmware.

#### steps
1. enter DFU mode
2. `dfu-util -d 2b04:d00a -a 0 -s 0x8060000 -D system-part1-x.y.z-electron.bin`
3. `dfu-util -d 2b04:d00a -a 0 -s 0x8020000 -D system-part2-x.y.z-electron.bin`
4. `dfu-util -d 2b04:d00a -a 0 -s 0x8040000:leave -D system-part3-x.y.z-electron.bin`

missing the `:leave` modifier on the last step will cause the device to remain in DFU mode, resetting manually will work

the only firmware that I have patched with remote user compilation is the `0.6.4` release.

### other notes

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
