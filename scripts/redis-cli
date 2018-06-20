#!/bin/bash

set -e

function set () {
    local key="$1"
    local value="$2"

    main "set" "$key" "$value"
}

function get () {
    local key="$1"

    main "get" "$key"
}

function append () {
    local key="$1"
    local value="$2"

    main "append" "$key" "value"
}

function main () {
    local command="$@"

    docker run -it --link redisserver:redis --rm redis redis-cli -h redis -p 6379 $command
}

if [ "$1" == "set" ] && [ $# -eq 3 ] ; then
    set "$2" "$3"
elif [ "$1" == "get" ] && [ $# -eq 2 ]; then
    get "$2"
elif [ "$1" == "append" ] && [ $# -eq 3 ]; then
    append "$2" "$3"
else
    shout "ALERT" "USAGE: redis-cli [set|get|append] [key] [value]"
fi
