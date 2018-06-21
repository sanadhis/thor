#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

function print-banner () {
	local message="$@"	

	echo -e "\n${COLOR}   $message ${NC}\n"
}

if [ $# -eq 0 ] || [ "$1" == "--help" ] || [ "$1" == "help" ] ; then
	export COLOR=$YELLOW
	print-banner "Usage: shout \"LEVEL(WARNING|ALERT|INFO|SUCCESS)\" \"MESSAGE\""
else
	# Decide color of banner
	if [ "$1" == "WARNING" ] || [ "$1" == "0" ] ; then
		export COLOR=$RED
	elif [ "$1" == "ALERT" ] || [ "$1" == "INFO" ]; then
		export COLOR=$YELLOW
	else
		export COLOR=$GREEN
	fi

	print-banner "${@:2}"
fi
