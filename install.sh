#!/bin/bash

set -e

function main () {
	for script in $(ls scripts)
	do
		install-script $script
	done
}

function install-script () {
	script="$1"

	source=$PWD/scripts/$script
	target=/usr/local/bin/$script

	sudo ln -sf $source $target
	shout "ALERT" "SYMLINK $source -> $target"
}

if [ $UID -ne 0 ] ; then
	shout "ALERT" "PLEASE RUN WITH SUDO"
else
	main "$@"
fi
