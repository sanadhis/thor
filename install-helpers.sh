#!/bin/bash

set -e

function main () {
	for helper in $(ls helpers)
	do
		install-helper $helper
	done
}

function install-helper () {
	script="$1"

	source=$PWD/helpers/$script
	target=/usr/local/bin/$script

	sudo ln -sf $source $target
	echo "SYMLINK $source -> $target"
}

if [ $UID -ne 0 ] ; then
	echo "PLEASE RUN WITH SUDO"
else
	main "$@"
fi
