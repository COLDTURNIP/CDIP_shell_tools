#!/bin/bash
# Program:
#   This script set the basic environment for projects.
#
#   The folloing functions needed by cdipPathUtils.sh .
#
# History:
# 20101102 First release. Refered to activate from Python PIP's virtualenv.
#


#######################
# Interface Functions #
#######################

function activate()
{
    # clean the previous environment
    deactivate nondestructive > /dev/null

    echo "activate project environment..."
    #
    # TODO: write down your initialization procedure here.
    #
}

function deactivate()
{
    echo "deactivate project environment..."
    #
    # TODO: write down your destruct procedure here.
    #

    if [ ! "$1" = "nondestructive" ]; then
        # Self destruct!
        unset -f activate
        unset -f deactivate
    fi
    uninstallenv
}

