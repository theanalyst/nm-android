# notmuch-android

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

    LD_LIBRARY_PATH=$PWD/lib:$PWD/lib64 ./notmuch

