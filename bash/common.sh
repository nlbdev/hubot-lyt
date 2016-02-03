#!/bin/bash
#
# Helper script to set common variables and define common functions
#

#####################################################################
#                 Environment variables and logging                 #
#####################################################################

set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HUBOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"

if [ "$DEBUG" = "1" ]; then
    set -v
fi

# capture all output in a temporary file
TEMP_LOGFILE="`tempfile`"
exec &> >(tee -ia $TEMP_LOGFILE)

# when a command outputs a non-zero value, before exiting;
# send last 10 lines of output from bash script as error message
function bash_script_error_exit {
    set +e
    message_error "`tail -n 10 "$TEMP_LOGFILE"`"
    rm "$TEMP_LOGFILE"
}
trap bash_script_error_exit EXIT

if [ "$LYT_REPO" = "" ]; then
    # The repo doesn't need to be persistent between runs so /tmp is fine
    LYT_REPO="/tmp/LYT"
fi

function message_error {
    echo $1
    echo $1 | "$DIR/slack" error
}

function message_warn {
    echo $1
    echo $1 | "$DIR/slack" warn
}

function message_info {
    echo $1
    echo $1 | "$DIR/slack"
}

function message_announcement {
    echo $1
    echo "<!channel> $1" | "$DIR/slack" info
}

function message_success {
    echo $1
    echo $1 | "$DIR/slack" success
}

function message_debug {
    echo $1
}


#####################################################################
#                          Common tasks                             #
#####################################################################

function repository_prepare {
    if [ ! -d "$LYT_REPO" ]; then
        message_debug "Mappen $LYT_REPO finnes ikke. Kloner LYT..."
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

function test_server_ip {
    curl -s http://whatismijnip.nl | cut -d " " -f 5
}

function test_server_hubot_shutdown {
    message_warn "Starter bot på nytt..."
    
    cd "$HUBOT_DIR"
    HUBOT_PID="`ps axo pid,command | grep -v grep | grep node_modules/.bin/hubot | awk '{print $1}'`"
    set +e
    kill $HUBOT_PID
    set -e
}
