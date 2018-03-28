#!/usr/bin/env bash

readonly root=$(dirname $0)
readonly proj="${root}/${1}"

if [[ -d ${proj} ]]; then
    for p in $(ls ${proj}/*.patch 2> /dev/null); do
      patch --binary -p 1 -i ${p}
    done
fi
