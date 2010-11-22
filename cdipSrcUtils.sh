#!/bin/bash
# Program:
#   This script provids some utility functions for programming, such as
#   searching in source files.
#
#   The folloing functions depend on cdipPathUtils.sh .
#
# History:
# 20100908 First release. Refered to envsetup.sh from Android project.
#



####################
# Global Variables #
####################

export CDIP_ENV=".cdip"


#####################
# Utility Functions #
#####################

function getCdipTagPath()
{
    local ret=$(gettop)
    if [[ -d $ret/$CDIP_ENV ]]; then
        echo $ret/$CDIP_ENV
    else
        echo $ret
    fi
}

case `uname -s` in
    Darwin)
        function sgrep()
        {
            T=$(getCdipTagPath)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\.\\(c\\|h\\|cpp\\|S\\|java\\|xml\\|sh\\|mk\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
                )
            else
                find -E . -type f -iregex '.*\.(c|h|cpp|S|java|xml|sh|mk)' -print0 | xargs -0 grep -H --color -C 1 -n "$@"
            fi
        }

        ;;
    *)
        function sgrep()
        {
            T=$(getCdipTagPath)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\.\\(c\\|h\\|cpp\\|S\\|java\\|xml\\|sh\\|mk\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
                )
            else
                find . -type f -iregex '.*\.\(c\|h\|cpp\|S\|java\|xml\|sh\|mk\)' -print0 | xargs -0 grep -H --color -C 1 -n "$@"
            fi
        }
        ;;
esac

function jgrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist_j ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/" $T/filelist_j | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
        )
    else
        find . -type f -name "*\.java" -print0 | xargs -0 grep -H --color -C 1 -n "$@"
    fi
}

function cgrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist_c ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/" $T/filelist_c | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
        )
    else
        find . -type f \( -name '*\.c' -o -name '*\.cc' -o -name '*\.cpp' -o -name '*\.h' \) -print0 | xargs -0 grep -H --color -C 1 -n "$@"
    fi
}

function hgrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist_c ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*\.h$" $T/filelist_c | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
        )
    else
        find . -type f -name "*\.h*" -print0 | xargs -0 grep -H --color -C 1 -n "$@"
    fi
}

function resgrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath\\(/.*\\)*/res/.*\\.xml$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -n "$@"
        )
    else
        for dir in `find . -name res -type d`; do find $dir -type f -name '*\.xml' -print0 | xargs -0 grep -H --color -n "$@"; done;
    fi
}

function xmlgrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*\\.xml$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -n "$@"
        )
    else
        for dir in `find . -name res -type d`; do find $dir -type f -name '*\.xml' -print0 | xargs -0 grep -H --color -n "$@"; done;
    fi
}

function pygrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*\\.py$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
        )
    else
        find . -type f -name "*\.py" -print0 | xargs -0 grep -H --color -C 1 -n "$@"
    fi
}

function vgrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*\\.\(\(vala\)\|\(vapi\)\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
        )
    else
        find . -type f \( -name '*\.vala' -o -name '*\.vapi' \) -print0 | xargs -0 grep -H --color -C 1 -n "$@"
    fi
}

function pygrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*\\.go$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
        )
    else
        find . -type f -name "*\.go" -print0 | xargs -0 grep -H --color -C 1 -n "$@"
    fi
}

function allgrep()
{
    T=$(getCdipTagPath)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -n "$@"
        )
    else
        find . -type f -print0 | xargs -0 grep -H --color -n "$@"
    fi
}

case `uname -s` in
    Darwin)
        function mgrep()
        {
            T=$(getCdipTagPath)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\<\\(Makefile\\|Makefile\\..*\\|.*\\.make\\|.*\\.mak\\|.*\\.mk\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
                )
            else
                find -E . -type f -iregex '.*/(Makefile|Makefile\..*|.*\.make|.*\.mak|.*\.mk)' -print0 | xargs -0 grep -H --color -C 1 -n "$@"
            fi
        }

        function treegrep()
        {
            T=$(getCdipTagPath)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\.\\(c\\|h\\|cpp\\|S\\|java\\|xml\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
                )
            else
                find -E . -type f -iregex '.*\.(c|h|cpp|S|java|xml)' -print0 | xargs -0 grep -H --color -C 1 -n -i "$@"
            fi
        }

        ;;
    *)
        function mgrep()
        {
            T=$(getCdipTagPath)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\<\\(Makefile\\|Makefile\\..*\\|.*\\.make\\|.*\\.mak\\|.*\\.mk\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
                )
            else
                find . -regextype posix-egrep -iregex '(.*\/Makefile|.*\/Makefile\..*|.*\.make|.*\.mak|.*\.mk)' -type f -print0 | xargs -0 grep -H --color -C 1 -n "$@"
            fi
        }

        function treegrep()
        {
            T=$(getCdipTagPath)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\.\\(c\\|h\\|cpp\\|S\\|java\\|xml\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep -H --color -C 1 -n "$@"
                )
            else
                find . -regextype posix-egrep -iregex '.*\.(c|h|cpp|S|java|xml)' -type f -print0 | xargs -0 grep -H --color -C 1 -n -i "$@"
            fi
        }

        ;;
esac

function csj()
{
    T=$(gettop)
    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP." >&2
    else
        local tagPath=$(getCdipTagPath)
        if [ -f $tagPath/cscope_j.out ] ; then
            cscope -d -f $tagPath/cscope_j.out -P $T
        else
            echo "code index files cscope_j.* are not found in $tagPath ."
        fi
    fi
    unset T
}

function csc()
{
    T=$(gettop)
    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP." >&2
    else
        local tagPath=$(getCdipTagPath)
        if [ -f $tagPath/cscope_c.out ] ; then
            cscope -d -f $tagPath/cscope_c.out -P $T
        else
            echo "code index files cscope_c.* are not found in $tagPath ."
        fi
    fi
    unset T
}

function mkfilelist () {
    local HERE=$PWD
    T=$(gettop)
    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP." >&2
        return
    fi
    (
        cd $T
        echo -n "Creating general index..."
        find . -wholename ./out -prune -o -wholename ./stubs -prune -o -type f > filelist
        echo " Done"
        if [ -d $CDIP_ENV ]; then
            mv filelist $CDIP_ENV/filelist
        else
            echo "can not find .cdip in this project, place filelist in the project root."
        fi
        cd $HERE
    )
}

function buildtag () {
    local HERE=$PWD
    T=$(gettop)
    if [ ! "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP." >&2
        return
    fi
    local tagPath=$(getCdipTagPath)
    (
        cd $tagPath
        for files in filelist \
                     filelist_c \
                     filelist_j \
                     cscope_c.out \
                     cscope_c.out.in \
                     cscope_c.out.po \
                     cscope_j.out \
                     cscope_j.out.in \
                     cscope_j.out.po \
                 ; do
            rm $files > /dev/null
        done
        unset files

        cd $T
        for files in .cdip_tags_c \
                     .cdip_tags_j \
                 ; do
            rm $files > /dev/null
        done
        unset files

        cd $T
        echo "$T"
        mkfilelist
        if [ ! -f $tagPath/filelist ]; then
            echo "Error: can not build tags from filelist."
            return
        fi

        echo "Construct file list for C&C++ ..."
        grep "\(\.[ch]$\)\|\(\.cpp\)\|\(\.hpp\)$" $tagPath/filelist > filelist_c
        if [ -s filelist_c ]; then
            echo "Creating cscope index for C&C++ ..."
            cscope -qvRUb -ifilelist_c | \
            awk '
            {
                count=$5
                total=$7
                stepNumber=50
                step=100/stepNumber
                if (total > 0) {
                    percent = count / total * 100
                    printf "\r%3d%% [", percent
                    i=0
                    while (i+step<=percent) {
                        printf "\033[1;33m#\033[0m"
                        i+=step
                    }
                    printf "\033[1;33m)\033[0m"
                    i+=step
                    while (i<100) {
                        printf "\033[1;31m.\033[0m"
                        i+=step
                    }
                    printf "] %d/%d symbols", count, total
                }
            }
            END {
                stepNumber=50
                step=100/stepNumber
                printf "\r100%% ["
                for (i=0; i<100; i+=step) {
                    printf "\033[1;32m#\033[0m"
                }
                printf "] "
            }
            '
            mv cscope.out cscope_c.out
            mv cscope.in.out cscope_c.out.in
            mv cscope.po.out cscope_c.out.po
            echo " ... Done                 "
            echo "Creating ctags index for C&C++ ..."
            ctags -L filelist_c -f .cdip_tags_c --verbose=yes | \
            awk '
            {
                count+=1
                stepNumber=50
                step=100/stepNumber
                if (systime()-lastTime>1) {
                    lastTime=systime()
                    if (total > 0) {
                        percent = count / total * 100
                        printf "\r%3d%% [", percent
                        i=0
                        while (i+step<=percent) {
                            printf "\033[1;33m#\033[0m"
                            i+=step
                        }
                        printf "\033[1;33m)\033[0m"
                        i+=step
                        while (i<100) {
                            printf "\033[1;31m.\033[0m"
                            i+=step
                        }
                        printf "] %d/%d symbols", count, total
                    }
                }
            }
            END {
                stepNumber=50
                step=100/stepNumber
                printf "\r100%% ["
                for (i=0; i<100; i+=step) {
                    printf "\033[1;32m#\033[0m"
                }
                printf "] "
            }
            ' total=`wc -l filelist_c | cut -d' ' -f1` count=0 lastTime=0
            if [ ! $tagPath = $PWD ]; then
                mv filelist_c cscope_c.* $tagPath
            fi
            echo " ... Done                 "
        else
            rm filelist_c
            echo "No any C/C++ files here, pass."
        fi

        echo "Construct file list for Java ..."
        grep "\.java$" $tagPath/filelist > filelist_j
        if [ -s filelist_j ]; then
            echo "Creating cscope index for Java ..."
            cscope -qvRUb -ifilelist_j | \
            awk '
            {
                count=$5
                total=$7
                stepNumber=50
                step=100/stepNumber
                if (total > 0) {
                    percent = count / total * 100
                    printf "\r%3d%% [", percent
                    i=0
                    while (i+step<=percent) {
                        printf "\033[1;33m#\033[0m"
                        i+=step
                    }
                    printf "\033[1;33m)\033[0m"
                    i+=step
                    while (i<100) {
                        printf "\033[1;31m.\033[0m"
                        i+=step
                    }
                    printf "] %d/%d symbols", count, total
                }
            }
            END {
                stepNumber=50
                step=100/stepNumber
                printf "\r100%% ["
                for (i=0; i<100; i+=step) {
                    printf "\033[1;32m#\033[0m"
                }
                printf "] "
            }
            '
            mv cscope.out cscope_j.out
            mv cscope.in.out cscope_j.out.in
            mv cscope.po.out cscope_j.out.po
            echo " ... Done                 "
            echo "Creating ctags index for Java ..."
            ctags -L filelist_j -f .cdip_tags_j --verbose=yes | \
            awk '
            {
                count+=1
                stepNumber=50
                step=100/stepNumber
                if (systime()-lastTime>1) {
                    lastTime=systime()
                    if (total > 0) {
                        percent = count / total * 100
                        printf "\r%3d%% [", percent
                        i=0
                        while (i+step<=percent) {
                            printf "\033[1;33m#\033[0m"
                            i+=step
                        }
                        printf "\033[1;33m)\033[0m"
                        i+=step
                        while (i<100) {
                            printf "\033[1;31m.\033[0m"
                            i+=step
                        }
                        printf "] %d/%d symbols", count, total
                    }
                }
            }
            END {
                stepNumber=50
                step=100/stepNumber
                printf "\r100%% ["
                for (i=0; i<100; i+=step) {
                    printf "\033[1;32m#\033[0m"
                }
                printf "] "
            }
            ' total=`wc -l filelist_j | cut -d' ' -f1` count=0 lastTime=0
            if [ ! $tagPath = $PWD ]; then
                mv filelist_j cscope_j.* $tagPath
            fi
            echo " ... Done                 "
        else
            rm filelist_j
            echo "No any Java files here, pass."
        fi
    )
    echo ""
    cd $HERE
}

function godir () {
    if [[ -z "$1" ]]; then
        echo "Usage: godir <regex>"
        return
    fi
    T=$(gettop)
    if [ ! -n "$T" -o ! -d "$T" ]; then
        echo "Couldn't locate the top of the tree.  Try setting TOP or using 'find'."
        return
    fi
    local tagPath=$(getCdipTagPath)
    if [[ ! -f $tagPath/filelist ]]; then
        echo "$tagPath/filelist is not exist."
        mkfilelist
        echo ""
    fi
    local lines
    lines=($(grep "$1" $tagPath/filelist | sed -e 's/\/[^/]*$//' | sort | uniq))
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

function reload () {
    source ~/.bashrc
}



####################
# Initial Settings #
####################

# Nothing to initialize. Pass.

