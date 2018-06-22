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

	grep -q -F "export PATH=\$PATH:\$HOME/.thor/helpers/bin" $HOME/.thor_profile \
		|| echo "export PATH=\$PATH:\$HOME/.thor/helpers/bin" >> $HOME/.thor_profile
}

function install-helper () {
	local script="$1"

	local executable=${script%.sh*}

	local source="$SCRIPTDIR/$script"
	local sourceBinary="$PWD/tmp/$executable"
	local target="$HOME/.thor/helpers/bin/$executable"

	# compile shell script to binary
	shc -f $source -o $sourceBinary
	$print "INFO" ": shc -f $source -o $sourceBinary"

	# move to $HOME
	sudo mv $sourceBinary $target
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
