#!/usr/bin/env bash

readonly root=$(dirname $0)
readonly proj="${root}/${1}"

if [[ -d ${proj} ]]; then
    for p in $(ls ${proj}/*.patch 2> /dev/null); do
      patch --dry-run -N --silent --binary -p 1 -i ${p}
      if [ $? -eq 0 ]; then
        patch --binary -p 1 -i ${p}
      fi
    done
fi
