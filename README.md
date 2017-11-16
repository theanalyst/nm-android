# notmuch-android

A port of notmuch to android.

Targeting Android 6+ (API v23) on arm64 (aka aarch64) for now.

## TODO

- Write JNI shim layer to wrap notmuch main() in a java class.
- Write a Java app with nice UI using it
- Port muchsync/mbsync?

## Prepare the dev environement

    # new bash shell
    bash

    # source the dev env
    source scripts/env.sh

    # download android ndk (1GB)
    scripts/prepare-env

    # download and build all deps
    scripts/rebuild-all


## Build notmuch

    scripts/notmuch-configure

## Prepare a release

This will copy the notmuch program and its dependencies to a release
dir, which you can copy over to the device.

    scripts/make-release

Push the resulting release/ dir on your device and in the directory of it run

    # note: scripts/push-release does this, more or less
    adb shell rm -rf /data/local/nm
    adb push release /data/local/nm
    adb shell

    # now in the device shell
    cd /data/local/nm
    LD_LIBRARY_PATH=$PWD/lib:$PWD/lib64 ./notmuch --config=$PWD/config

**NOTE**: you probably need a rooted device to run raw binaries like
above (only option until the JNI shim is done).
