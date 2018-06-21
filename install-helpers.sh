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
	export SCRIPTDIR="$PWD/helpers"
	
	for helper in $(ls $SCRIPTDIR)
	do
		install-helper $helper
	done
}

function install-helper () {
	local script="$1"

	local executable=${script%.sh*}

	local source="$SCRIPTDIR/$script"
	local sourceBinary="tmp/$executable"
	local target="/usr/local/bin/$executable"

	# compile shell script to binary
	shc -f $source -o $sourceBinary
	$print "INFO" ": shc -f $source -o $sourceBinary"

	# move to /usr/local/bin
	sudo mv $sourceBinary $target
	$print "SUCCESS" ": INSTALLING $source -> $target"

	# Remove generated C source code
	rm "$source.x.c"
}

before

if [ $UID -ne 0 ] ; then
	$print "INFO" ": PLEASE RUN WITH SUDO"
else
	main "$@"
fi
