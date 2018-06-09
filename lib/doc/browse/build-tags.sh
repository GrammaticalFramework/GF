#!/bin/sh
#
# Script for building tags files for all RGL
# John J. Camilleri, 2014
#
#set -o errexit

dir=`pwd`
basedir=${dir}/../../src
tagsdir=${dir}/tags
index=${dir}/index.json
ignore="demo old-demo tmp"
start=`date +%s`

# Commands on GNU linux
# FIND="find -maxdepth 1 -name '*.gf'"
# STAT="stat --format=%Y"
# SED='sed'

# Commands on OSX
FIND="find *.gf -maxdepth 1"
STAT="stat -f %a"
SED='gsed'

# Function for testing array membership
in_ignore() {
    local search="$1"
    for i in $ignore; do
        if [ "$i" = "$search" ]; then
            return 0
        fi
    done
    return 1
}

# Make the dir just to be sure
[ -d ${tagsdir} ] || mkdir ${tagsdir}

# Iterate and build all the tags (takes some time)
rm -f $index
echo "{\n\"urlprefix\": \"/\"," >> $index
echo "\"languages\": {" >> $index
for dir in `ls "$basedir/"`
do
    if ! in_ignore $dir && [ -d "$basedir/$dir" ] ; then
        cd $basedir/$dir
        echo "Processing folder:" `pwd`
        echo "  \"${dir}\": [" >> $index
        $FIND | while read -r file
        do
            echo "    \""`echo $file | sed 's|./||;s|.gf||'`"\"," >> $index
            filemtime=`$STAT "${tagsdir}/${file}-tags" 2>/dev/null`
            if [ -z "$filemtime" ] || [ "$filemtime" -lt "$start" ]
            then
                gf --batch --quiet --tags --output-dir=${tagsdir} $file 2>/dev/null
            fi
        done
        echo "    \"\"\n  ]," >> $index
    fi
done
echo "  \"\":{}\n}\n}" >> $index

# Replace all URLs
echo "Replacing URLs"
cd $tagsdir
$SED --in-place --regexp-extended "s|\S+?/lib/|/lib/|g" *.gf-tags

exit 0
