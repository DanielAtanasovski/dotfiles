#!/bin/bash

# VS-code insiders
# Check if code-insiders is installed
if command -v code-insiders &> /dev/null; then
  alias code="code-insiders"
fi

# Define the code function
function code() {
  command code "$@"
}

## Helpful functions ##

function refresh_git(){
    DEFAULT_BRANCH=$1
    if [[ -z $DEFAULT_BRANCH || $DEFAULT_BRANCH == "" ]] ; then
        echo "YOU DIDN'T MENTION THE DEFAULT BRANCH!!"
        return
    fi

    git checkout "$DEFAULT_BRANCH" && git pull
    
    # Clear all local branches
    for branch in $(git branch | grep -v "$DEFAULT_BRANCH"); do
        git branch -D "$branch"
    done

    # Prune old local 'remote' branches
    git remote prune origin
}

# Get all namespaces and the 'live' labels associated with them
function get_live_label(){
    kubectl get ns -o json 2>/dev/null | jq -c '.items[] as $i | [$i.metadata.name, $i.metadata.labels.live]'
}

function awslogin() {
    if [[ -z "${1}" ]] ; then
        echo "ERROR: account name required, e.g. awslogin core-nonprod" >&2
        return 1
    fi

    if [ ! -z "${AWS_PROFILE}" ]; then
        unset AWS_PROFILE
    fi

    AWSLOGIN_PROFILE="${1}"
    shift

    CREDENTIALS="$(aws configure export-credentials --format env --profile "${AWSLOGIN_PROFILE}" 2>/dev/null)"

    if [ "$?" -ne 0 ]; then
        echo "Refreshing AWS authentication"
        aws sso login "$@"

        CREDENTIALS="$(aws configure export-credentials --format env)"
    fi

    # resolve region from profile > default
    if AWS_REGION=$(aws configure get region --profile "${AWSLOGIN_PROFILE}") ; then
        AWS_DEFAULT_REGION=${AWS_REGION}
    elif AWS_REGION=$(aws configure get region) ; then
        AWS_DEFAULT_REGION=${AWS_REGION}
    fi
    AWS_PROFILE="${AWSLOGIN_PROFILE}"
    export AWS_REGION AWS_DEFAULT_REGION AWS_PROFILE
    eval "${CREDENTIALS}"
}
