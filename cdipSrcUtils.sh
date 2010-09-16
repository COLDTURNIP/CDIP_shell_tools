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



#####################
# Utility Functions #
#####################

case `uname -s` in
    Darwin)
        function sgrep()
        {
            T=$(gettop)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\.\\(c\\|h\\|cpp\\|S\\|java\\|xml\\|sh\\|mk\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
                )
            else
                find -E . -type f -iregex '.*\.(c|h|cpp|S|java|xml|sh|mk)' -print0 | xargs -0 grep --color -C 1 -n "$@"
            fi
        }

        ;;
    *)
        function sgrep()
        {
            T=$(gettop)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\.\\(c\\|h\\|cpp\\|S\\|java\\|xml\\|sh\\|mk\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
                )
            else
                find . -type f -iregex '.*\.\(c\|h\|cpp\|S\|java\|xml\|sh\|mk\)' -print0 | xargs -0 grep --color -C 1 -n "$@"
            fi
        }
        ;;
esac

function jgrep()
{
    T=$(gettop)    
    if [[ -f $T/filelist_j ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/" $T/filelist_j | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
        )
    else
        find . -type f -name "*\.java" -print0 | xargs -0 grep --color -C 1 -n "$@"
    fi
}

function cgrep()
{
    T=$(gettop)    
    if [[ -f $T/filelist_c ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/" $T/filelist_c | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
        )
    else
        find . -type f \( -name '*\.c' -o -name '*\.cc' -o -name '*\.cpp' -o -name '*\.h' \) -print0 | xargs -0 grep --color -C 1 -n "$@"
    fi
}

function hgrep()
{
    T=$(gettop)    
    if [[ -f $T/filelist_c ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*\.h$" $T/filelist_c | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
        )
    else
        find . -type f -name "*\.h*" -print0 | xargs -0 grep --color -C 1 -n "$@"
    fi
}

function resgrep()
{
    T=$(gettop)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath\\(/.*\\)*/res/.*\\.xml$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -n "$@"
        )
    else
        for dir in `find . -name res -type d`; do find $dir -type f -name '*\.xml' -print0 | xargs -0 grep --color -n "$@"; done;
    fi
}

function xmlgrep()
{
    T=$(gettop)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*\\.xml$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -n "$@"
        )
    else
        for dir in `find . -name res -type d`; do find $dir -type f -name '*\.xml' -print0 | xargs -0 grep --color -n "$@"; done;
    fi
}

function pygrep()
{
    T=$(gettop)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*\\.py$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
        )
    else
        find . -type f -name "*\.py" -print0 | xargs -0 grep --color -C 1 -n "$@"
    fi
}

function allgrep()
{
    T=$(gettop)    
    if [[ -f $T/filelist ]]; then
        echo "Searching in cache file..."
        (
            local rpath=$(getrelative)
            local HERE=$PWD
            grep "^$rpath/.*" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -n "$@"
        )
    else
        find . -type f -print0 | xargs -0 grep --color -n "$@"
    fi
}

case `uname -s` in
    Darwin)
        function mgrep()
        {
            T=$(gettop)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\<\\(Makefile\\|Makefile\\..*\\|.*\\.make\\|.*\\.mak\\|.*\\.mk\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
                )
            else
                find -E . -type f -iregex '.*/(Makefile|Makefile\..*|.*\.make|.*\.mak|.*\.mk)' -print0 | xargs -0 grep --color -C 1 -n "$@"
            fi
        }

        function treegrep()
        {
            T=$(gettop)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\.\\(c\\|h\\|cpp\\|S\\|java\\|xml\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
                )
            else
                find -E . -type f -iregex '.*\.(c|h|cpp|S|java|xml)' -print0 | xargs -0 grep --color -C 1 -n -i "$@"
            fi
        }

        ;;
    *)
        function mgrep()
        {
            T=$(gettop)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\<\\(Makefile\\|Makefile\\..*\\|.*\\.make\\|.*\\.mak\\|.*\\.mk\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
                )
            else
                find . -regextype posix-egrep -iregex '(.*\/Makefile|.*\/Makefile\..*|.*\.make|.*\.mak|.*\.mk)' -type f -print0 | xargs -0 grep --color -C 1 -n "$@"
            fi
        }

        function treegrep()
        {
            T=$(gettop)    
            if [[ -f $T/filelist ]]; then
                echo "Searching in cache file..."
                (
                    local rpath=$(getrelative)
                    local HERE=$PWD
                    grep "^$rpath/.*\\.\\(c\\|h\\|cpp\\|S\\|java\\|xml\\)$" $T/filelist | sed -e "s:^$rpath:\\.:" | xargs grep --color -C 1 -n "$@"
                )
            else
                find . -regextype posix-egrep -iregex '.*\.(c|h|cpp|S|java|xml)' -type f -print0 | xargs -0 grep --color -C 1 -n -i "$@"
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
        if [ -f $T/cscope_j.out ] ; then
            cscope -d -f $T/cscope_j.out -P $T
        else
            echo "code index files cscope_j.* are not found, use command refresh to construct."
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
        if [ -f $T/cscope_c.out ] ; then
            cscope -d -f $T/cscope_c.out -P $T
        else
            echo "code index files cscope_c.* are not found, use command refresh to construct."
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
    (
        cd $(gettop)
        for files in filelist \
                     filelist_c \
                     filelist_j \
                     cscope_c.out \
                     cscope_c.out.in \
                     cscope_c.out.po \
                     cscope_j.out \
                     cscope_j.out.in \
                     cscope_j.out.po \
                     tags_c \
                     tags_j \
                 ; do
            if [ -f $T/$files ] ; then
                rm $files
            fi
        done
        unset files

        echo "$T"
        mkfilelist

        echo "Construct file list for C&C++ ..."
        grep "\(\.[ch]$\)\|\(\.cpp\)\|\(\.hpp\)$" filelist > filelist_c
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
            ctags -L filelist_c -f tags_c --verbose=yes | \
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
            echo " ... Done                 "
        else
            rm filelist_c
            echo "No any C/C++ files here, pass."
        fi

        echo "Construct file list for Java ..."
        grep "\.java$" filelist > filelist_j
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
            ctags -L filelist_j -f tags_j --verbose=yes | \
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
            echo " ... Done                 "
        else
            rm filelist_j
            echo "No any Java files here, pass."
        fi
    )
    echo ""
    cd $HERE
}

function reload () {
    source ~/.bashrc
}



####################
# Initial Settings #
####################

# Nothing to initialize. Pass.

