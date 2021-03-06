#!/bin/bash

set -e

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$message"
    echo "##################################"
}

function update-apt () {
    print-banner "update-apt"    
    sudo apt-get update
}

function apt-via-https () {
    print-banner "Install packages for allowing apt to use https"    
    sudo apt-get install \
                apt-transport-https \
                ca-certificates \
                curl \
                software-properties-common
}

function pre-installation () {
    print-banner "Add Docker's official GPG key"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -    
    print-banner "Verify key"    
    sudo apt-key fingerprint 0EBFCD88
    print-banner "Setup stable repository"    
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
}

function install () {
    print-banner "Install docker-ce stable"
    sudo apt-get update && sudo apt-get install -y docker-ce
    print-banner "Activating Docker as non-root user"
    sudo usermod -aG docker $(whoami)
    print-banner "Issue sudo usermod -aG docker <other_user> to allow other user to use docker. Don't forget to restart the user session!"
}

function main () {
    update-apt
    apt-via-https
    pre-installation
    update-apt
    install   
}

if  [ "$UID" -ne 0 ] ; then
    echo "Please run as root"
else
    main "$@"
fi
