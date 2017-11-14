#!/bin/bash
export NM_ROOT=$(readlink -f $(dirname "$BASH_SOURCE")/..)
export NM_BUILD=$NM_ROOT/build/arm64-libcpp-23/
export NM_SCRIPT=$NM_ROOT/scripts
export NM_OUT=$NM_ROOT/out
export NM_SRC=$NM_ROOT/src


function prepend_path() {
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        PATH="$1:$PATH"
    fi
    export PATH
}

if ! echo "$PS1" | grep -q 'NMDEV'; then
    export PS1="(NMDEV) $PS1"
fi

# Add the standalone toolchain to the search path.
prepend_path $NM_OUT/bin
prepend_path $NM_BUILD/bin

# Tell configure what tools to use.
target_host=aarch64-linux-android
export AR=$target_host-ar
export AS=$target_host-as
export CC=$target_host-gcc
export CXX=$target_host-g++
export LD=$target_host-ld
export STRIP=$target_host-strip

# Tell configure what flags Android requires.
export CFLAGS="-fPIE -fPIC -I$NM_OUT/include -D__ANDROID__ -D_LARGEFILE_SOURCE=1 -D_LARGE_FILES -D_FILE_OFFSET_BITS=64"
export CXXFLAGS="-fPIE -fPIC -I$NM_OUT/include -D__ANDROID__ -D_LARGEFILE_SOURCE=1 -D_LARGE_FILES -D_FILE_OFFSET_BITS=64 -isystem $NM_BUILD/include/c++/4.9.x"
export LDFLAGS="-pie -L$NM_OUT/lib"

export PKG_CONFIG_PATH=$NM_OUT/lib/pkgconfig
export PKG_CONFIG_LIBDIR=$NM_OUT/lib


function reload() {
    source $NM_SCRIPT/env.sh
}

alias e="emacs -nw"
