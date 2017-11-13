#!/bin/bash
export NM_ROOT=$(readlink -f $(dirname "$BASH_SOURCE")/..)
export NM_BUILD=$NM_ROOT/build/arm64-libcpp-23/
export NM_SCRIPT=$NM_ROOT/scripts
export NM_OUT=$NM_ROOT/out
export NM_SRC=$NM_ROOT/src

if ! echo "$PS1" | grep -q 'NMDEV'; then
    export PS1="(NMDEV) $PS1"
fi

# Add the standalone toolchain to the search path.
export PATH=$NM_BUILD/bin:$PATH

# Tell configure what tools to use.
target_host=aarch64-linux-android
export AR=$target_host-ar
export AS=$target_host-as
export CC=$target_host-gcc
export CXX=$target_host-g++
export LD=$target_host-ld
export STRIP=$target_host-strip

# Tell configure what flags Android requires.
export CFLAGS="-fPIE -fPIC"
export CXXFLAGS="-fPIE -fPIC"
export LDFLAGS="-pie"
