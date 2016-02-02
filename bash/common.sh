#!/bin/bash
#
# Helper script to set common variables and define common functions
#

set -e

if [ "$DEBUG" = "1" ]; then
    set -v
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$LYT_REPO" = "" ]; then
    # The repo doesn't need to be persistent between runs so /tmp is fine
    LYT_REPO="/tmp/LYT"
fi

function message_info {
    echo $1
    echo $1 | "$DIR/slack"
}

function message_debug {
    echo $1
}

function repository_prepare {
    if [ ! -d "$LYT_REPO" ]; then
        message_debug "The directory $LYT_REPO does not exist. Cloning LYT..."
        git clone "https://github.com/nlbdev/LYT.git" "$LYT_REPO"
        cd $LYT_REPO
        git remote add notalib "https://github.com/Notalib/LYT.git"
    fi
    
    cd $LYT_REPO
    git reset --hard
    git clean -d -x -f # not needed maybe?
    if [ "`git branch --list nlb | wc -l`" = "0" ]; then
        git checkout -b nlb --track origin/nlb
    else
        git checkout nlb
    fi
    git pull --all
}
