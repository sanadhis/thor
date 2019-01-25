#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function pre-installation () {
    print-banner "Getting anaconda installation script"
    mkdir -p $HOME/.temp
    # With Python 2 (Miniconda 2)
    # wget https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh \
    #     -O $HOME/.temp/conda.sh
    # With Python 3 (Miniconda 3) - default
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
        -O $HOME/.temp/conda.sh
    chmod +x $HOME/.temp/conda.sh
}

function main () {
    print-banner "Installing miniconda"
    pushd $HOME/.temp
    ./conda.sh
    popd
}

function post-installation () {
    rm -rf $HOME/.temp
}

if  [ "$UID" -eq 0 ] ; then
    echo "Please do not run as root"
else
    pre-installation
    main "$@"
    post-installation
fi