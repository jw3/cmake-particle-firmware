#!/usr/bin/env bash

if [ -z "$1" ]; then echo "usage: build <platform>"; exit 1; fi

readonly platform="$1"

rm -rf build
mkdir build
cd build
cmake .. -DPLATFORM="$platform"
make
