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
    # Example: for Android, import envsetup.sh for build
    #
    #     source build/envsetup.sh
    #     lunch 8
}

function deactivate()
{
    echo "deactivate project environment..."
    #
    # TODO: write down your destruct procedure here.
    #
    # Example: for Android, clear the functions imported from envsetup.sh
    #
    #     for shf in `/bin/ls vendor/*/vendorsetup.sh vendor/*/build/vendorsetup.sh 2> /dev/null`
    #     do
    #         echo "unset functions from $shf"
    #         unsetFunctionFromSh $shf
    #     done
    #     unset f

    if [ ! "$1" = "nondestructive" ]; then
        # Self destruct!
        unset -f activate
        unset -f deactivate
    fi
    uninstallenv
}

