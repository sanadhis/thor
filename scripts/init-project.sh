#!/bin/bash

set -e

function getToken () {
    redis-cli get githubToken | tr -d '"'
}


function main () {
    local username="$1"
    local repositoryName="$2"
    local params="${@:2}"

    local token=$(getToken)

    # remove the newline character -> "\n" using %?
    # create repo
    createRepo "${token%?}" $params

    # clone repo
    clone $username $repositoryName
}

function createRepo () {
    local token="$1"
    local repoName="$2"
    local license="$3"
    local language="$4"

    shout "INFO" "{ \"name\":\"$repoName\" , \"license_template\": \"$license\" , \"gitignore_template\": \"$language\"}"

    curl -XPOST \
        -H "Authorization: token $token" \
        https://api.github.com/user/repos \
        -d "{ \"name\":\"$repoName\" , \"license_template\": \"$license\" , \"gitignore_template\": \"$language\"}"
    
    shout $? "CREATING GITHUB REPOSITORY" 
}

if [ $# -le 2 ] ; then
    shout "INFO" "USAGE: init-project [username] [repository_name] [license] [language]"
else
    main "$@"
fi
