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
export CFLAGS="-fPIE -fPIC -I$NL_OUT/include -D__ANDROID__ -D_LARGEFILE_SOURCE=1 -D_LARGE_FILES -D_FILE_OFFSET_BITS=64 -isystem $NM_BUILD/include/c++/4.9.x"
export CXXFLAGS="-fPIE -fPIC -I$NL_OUT/include -D__ANDROID__ -D_LARGEFILE_SOURCE=1 -D_LARGE_FILES -D_FILE_OFFSET_BITS=64 -isystem $NM_BUILD/include/c++/4.9.x"
export LDFLAGS="-pie -L$NM_OUT/lib"
