#!/usr/bin/env bash

if [[ -z "$1" ]]; then echo "usage: build.sh <platform>"; exit 1; fi

readonly platform="$1"
readonly builddir="build-$platform"

if [[ ! -z "$GCC_ARM_PATH" ]]; then gcc_path_arg="-DGCC_ARM_PATH=$GCC_ARM_PATH"; fi
if [[ ! -z "$FIRMWARE_DIR" ]]; then firmware_dir_arg="-DFIRMWARE_DIR=$FIRMWARE_DIR"; fi

if [[ -z "$FIRMWARE_VERSION" ]]; then echo "FIRMWARE_VERSION is required"; exit 1; fi
readonly firmware="$FIRMWARE_VERSION"

if [[ "$2" != "quick" ]]; then
  rm -rf "$builddir"
  mkdir "$builddir"
fi

if [[ ! -d "$builddir" ]]; then mkdir "$builddir"; fi

cd "$builddir"
cmake .. -DPLATFORM="$platform" -DFIRMWARE_VERSION="$firmware" ${gcc_path_arg} ${firmware_dir_arg}
make -j1
