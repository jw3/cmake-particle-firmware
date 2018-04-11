#!/usr/bin/env bash

if [ -z "$1" ]; then echo "usage: build.sh <platform>"; exit 1; fi

readonly platform="$1"
readonly builddir="build-$platform"

if [[ "$2" != "quick" ]]; then
  rm -rf "$builddir"
  mkdir "$builddir"
fi

if [ ! -d "$builddir" ]; then mkdir "$builddir"; fi

cd "$builddir"
cmake .. -DPLATFORM="$platform"
make -j1
