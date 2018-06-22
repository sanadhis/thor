#!/bin/bash

function git-clone (){
    local user="$1"
    local repositoryName="$2"
    local gitSource="${3:-github.com}"
    
    local gitRemoteUrl=git@$gitSource:$user/$repositoryName.git

    shout "ALERT" "cloning $gitRemoteUrl"
    git clone ${gitRemoteUrl}
    shout "SUCCESS" "CLONE DONE"
}

if [ $# -le 1 ] ; then
    shout "ALERT" "USAGE: clone [username] [repository_name] [github.com|bitbucket.org|gitlab.com]"
else
    git-clone "$@"
fi
