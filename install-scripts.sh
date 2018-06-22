#!/bin/bash

set -e

function before () {
    if hash shout 2>/dev/null; then
        export print=shout
    else
        export print=echo
    fi
}

function main () {
    export SCRIPTDIR="$PWD/scripts"

    for script in $(ls $SCRIPTDIR)
    do
        install-script $script
    done

    grep -q -F "export PATH=\$PATH:\$HOME/.thor/scripts/bin" $HOME/.thor_profile \
        || echo "export PATH=\$PATH:\$HOME/.thor/scripts/bin" >> $HOME/.thor_profile
}

function install-script () {
    local script="$1"

    local executable=${script%.sh*}

    local source="$SCRIPTDIR/$script"
    local sourceBinary="$PWD/tmp/$executable"
    local target="$HOME/.thor/scripts/bin/$executable"

    # compile shell script to binary
    shc -f $source -o $sourceBinary
    $print "INFO" "shc -f $source -o $sourceBinary"

    # move to $HOME
    mv $sourceBinary $target
    $print "SUCCESS" ": INSTALLING $sourceBinary -> $target"

    # Remove generated C source code
    rm "$source.x.c"
}

before

if [ $UID -eq 0 ] ; then
    $print "ALERT" ": PLEASE DO NOT RUN WITH SUDO"
else
    main "$@"
fi
