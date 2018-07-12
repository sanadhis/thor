#!/bin/bash

if [ $# -ne 1 ] ; then
    target=$PWD
else
    target="$1"
fi

ls -1 $target | xargs du -hs 
