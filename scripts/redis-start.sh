#!/bin/bash

function clean () {
    docker stop redisserver
    docker rm redisserver
}

function main () {
    docker run --name redisserver -v $HOME/.redis:/data -d redis redis-server --appendonly yes
}

clean
main

if [ $? -eq 0 ] ; then
    shout "SUCCESS" "Redis Server STARTED"
else
    shout "WARNING" "Redis Server fails to start"
fi
