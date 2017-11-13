#!/bin/bash
export NM_ROOT=$(readlink -f $(dirname "$BASH_SOURCE")/..)
export NM_BUILD=$NM_ROOT/build/arm64-libcpp-23/

if ! echo "$PS1" | grep -q 'NMDEV'; then
    export PS1="(NMDEV) $PS1"
fi

