#!/bin/bash
# Program:
#   This script provids some utility functions for path management, such as
#   quich swiching directory in projects.
#
#   Some of the folloing functions needed by cdipPathUtils.sh .
#
# History:
# 20100908 First release. Refered to envsetup.sh from Android project.
#



#####################
# Utility Functions #
#####################

function getrelative()
{
    local pattern=`echo $(gettop) | sed -e 's:/:\\\\/:g'`
    echo `echo $PWD | sed -e "s:^$pattern:\\.:"`;
}

function gettop
{
    if [ -n "$CDIP_TOP" ] ; then
        echo $CDIP_TOP
    elif [ -n "$TOP" ] ; then
        echo $TOP
    fi
}

function settop
{
    local target=$1
    if [[ -z "$target" ]]; then
        target=$PWD
    fi
    local choice
    if [ -d $target ]; then
        printf "Set root path to  %s ? [Y/n] " $target
        read choice
        choice=`echo $choice | tr '[A-Z]' '[a-z]'`
        if [ "$choice" == 'no' -o "$choice" == 'n' ]; then
        echo 'Do nothing.'
        else
            export CDIP_TOP=$(pwd $target)
            printf "%s is root path now.\n" $CDIP_TOP
        fi
    else
        printf "Invalid path %s . Please check your silly path  :(\n" $target
    fi
}

function croot()
{
    T=$(gettop)
    if [ "$T" ]; then
        cd $(gettop)
    else
        echo "Couldn't locate the top of the tree.  Try setting TOP."
    fi
}

function godir () {
    if [[ -z "$1" ]]; then
        echo "Usage: godir <regex>"
        return
    fi
    T=$(gettop)
    if [ ! -n "$T" -o ! -f "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP or using 'find'."
        return
    fi
    if [[ ! -f $T/filelist ]]; then
        mkfilelist
        echo ""
    fi
    local lines
    lines=($(grep "$1" $T/filelist | sed -e 's/\/[^/]*$//' | sort | uniq))
    if [[ ${#lines[@]} = 0 ]]; then
        echo "Not found"
        return
    fi
    local pathname
    local choice
    if [[ ${#lines[@]} > 1 ]]; then
        while [[ -z "$pathname" ]]; do
            local index=1
            local line
            for line in ${lines[@]}; do
                printf "%6s %s\n" "[$index]" $line
                index=$(($index + 1))
            done
            echo
            echo -n "Select one: "
            unset choice
            read choice
            if [[ $choice -gt ${#lines[@]} || $choice -lt 1 ]]; then
                echo "Invalid choice"
                continue
            fi
            pathname=${lines[$(($choice-$_arrayoffset))]}
        done
    else
        # even though zsh arrays are 1-based, $foo[0] is an alias for $foo[1]
        pathname=${lines[0]}
    fi
    cd $T/$pathname
}

function goproj () {
    local WORKSRC=$HOME/worksrc/
    local MYWORKSRC=$HOME/mysrc/

    local target=$1
    if [[ -z "$target" ]]; then
        target=".*"
    fi
    echo -n "Creating index..."
    (cd $WORKSRC; find $WORKSRC -mindepth 1 -maxdepth 1 \( -type d -o -type l \) > projlist)
    (cd $MYWORKSRC; find $MYWORKSRC -mindepth 1 -maxdepth 1 \( -type d -o -type l \) > projlist)
    echo " Done"
    echo ""
    local lines
    lines=($(grep "$target" $WORKSRC/projlist $MYWORKSRC/projlist | sed -e 's/^.*://' | sort | uniq))
    if [[ ${#lines[@]} = 0 ]]; then
        echo "Not found"
        return
    fi
    local projname
    local choice
    if [[ ${#lines[@]} > 1 ]]; then
        while [[ -z "$projname" ]]; do
            local index=1
            local line
            for line in ${lines[@]}; do
                printf "%6s %s\n" "[$index]" $line
                index=$(($index + 1))
            done
            echo
            echo -n "Select one: "
            unset choice
            read choice
            if [[ $choice -gt ${#lines[@]} || $choice -lt 1 ]]; then
                echo "Invalid choice"
                continue
            fi
            projname=${lines[$(($choice-$_arrayoffset))]}
        done
    else
        # even though zsh arrays are 1-based, $foo[0] is an alias for $foo[1]
        projname=${lines[0]}
    fi
    cd $projname

    # import project environment settings
    prepareenv
}

function prepareenv () {
    local ANDROID_ENV=build/envsetup.sh

    if [[ -f $ANDROID_ENV ]]; then
        echo "including $ANDROID_ENV"
        . $ANDROID_ENV
        export CDIP_TOP=$PWD
    fi
    if [[ -f $CDIP_ENV ]]; then
        # Execute the contents of any vendorsetup.sh files we can find.
        for f in `/bin/ls .cdip/envsetup*.sh 2> /dev/null`
        do
            echo "including $f"
            . $f
        done
        unset f
        export CDIP_TOP=$PWD
    fi

    # global override
    . ~/bin/cdipSrcUtils.sh
}



####################
# Initial Settings #
####################

# decide array indexing scheme
if [ -z "${_xarray[${#_xarray[@]}]}" ]
then
    _arrayoffset=1
else
    _arrayoffset=0
fi
unset _xarray

# scan environment settings
prepareenv

