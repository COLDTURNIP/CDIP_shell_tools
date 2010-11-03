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
            export CDIP_TAG_PATH=$(getCdipTagPath)
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
    installenv
}

function initproj() {
    local PROJ_UTIL_DIR=$HOME/bin/cdipTemplateRcDir

    if [[ -e .cdip ]]; then
        echo "Error: There's .cdip folder. If you are sure to setup a project here, please remove it first."
        return
    elif [[ -d $PROJ_UTIL_DIR ]]; then
        cp -Lr $PROJ_UTIL_DIR .cdip
        settop
        echo ""
        echo "    Note: Do not forget overriding the activate/deactivate functions."
        echo ""
        echo "    Step 1. Edit .cdip/envsetup.sh (vi .cdip/envsetup.sh)"
        echo "    Step 2. Import envsetup.sh to activate (source .cdip/envsetup.sh)"
        echo ""
    else
        echo "Error: Can not find environment template directory. Nothing to do."
        return
    fi
}

function installenv() {
    local CDIP_ENV=".cdip"

    if [[ -f $CDIP_ENV/envsetup.sh ]]; then
        source $CDIP_ENV/envsetup.sh
        activate
        export CDIP_TOP=$PWD
        export CDIP_TAG_PATH=$(getCdipTagPath)
    fi

    # global override
    . ~/bin/cdipSrcUtils.sh
}

function uninstallenv() {
    unset CDIP_TOP
    unset CDIP_TAG_PATH
    unset TOP
}

function unsetFunctionFromSh()
{
    T=$(gettop)
    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP." >&2
        return
    fi

    local HERE=$PWD
    cd $T
    for f in $@; do
        if [[ -f $f ]]; then
            for funcToRm in `cat $f | sed -n "/^\s*function /s/^\s*function\s\+\([a-zA-Z]\w\+\).*/\1/p" | sort`; do
                unset -f $funcToRm
            done
        fi
    done
    cd $HERE > /dev/null
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

