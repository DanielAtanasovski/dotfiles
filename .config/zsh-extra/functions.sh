#!/bin/bash

## Helpful functions ##

function refresh_git(){
    DEFAULT_BRANCH=$1
    if [[ -z $DEFAULT_BRANCH || $DEFAULT_BRANCH == "" ]] ; then
        echo "YOU DIDN'T MENTION THE DEFAULT BRANCH!!"
        return
    fi

    git checkout "$DEFAULT_BRANCH" && git pull && git branch -d "$(git branch | grep -v "$DEFAULT_BRANCH")"
}

# Get all namespaces and the 'live' labels associated with them
function get_live_label(){
    kubectl get ns -o json 2>/dev/null | jq -c '.items[] as $i | [$i.metadata.name, $i.metadata.labels.live]'
}

function kinstall(){
    if [[ -z "${1}" ]] ; then
        echo "ERROR: App name required, e.g. hammerhead"
        return 1
    fi

    if [[ -z "${2}" ]] ; then
        echo "ERROR: App version required, e.g. hammerhead"
        return 1
    fi

    if [[ -z "${3}" ]] ; then
        echo "ERROR: Namespace name required, e.g. hammerhead"
        return 1
    fi

    echo "Install ${1}:${2} into namespace ${3}... Okay..."


    # TODO: Check if files exist

    helm install -n "${3}" -f ~/stash/kubernetes-configuration-files/global/"${3}".yml -f ~/stash/kubernetes-configuration-files/specific/"${2}"/default.yml -f ~/stash/kubernetes-configuration-files/specific/"${2}"/"${3}".yml "${1}" helm-internal/"${1}" --version v"$2"
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
        aws sso login $@

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
