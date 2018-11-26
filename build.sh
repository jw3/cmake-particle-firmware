#!/usr/bin/env bash

if [[ -z "$1" ]]; then echo "usage: build.sh <platform>"; exit 1; fi

readonly platform="$1"
readonly builddir="build-$platform"

if [[ -z "$FIRMWARE_VERSION" ]]; then echo "FIRMWARE_VERSION is required"; exit 1; fi
readonly firmware="$FIRMWARE_VERSION"

if [[ "$2" != "quick" ]]; then
  rm -rf "$builddir"
  mkdir "$builddir"
fi

if [[ ! -d "$builddir" ]]; then mkdir "$builddir"; fi

cd "$builddir"
cmake .. -DPLATFORM="$platform" -DFIRMWARE_VERSION="$firmware"
make -j1
