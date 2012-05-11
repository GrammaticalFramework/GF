#!/bin/sh

##
# Script for building tags files for all RGL
# John J. Camilleri, 2012
##

dir=`pwd`
basedir=${dir}/../../src
tagsdir=${dir}/tags
index=${dir}/index.json
removeprefix="/home/john/repositories/GF"

# Iterate and build all the tags (takes some time)
rm -f $index
echo "{\n\"languages\": {" >> $index
for dir in `ls "$basedir/"`
do
  if [ -d "$basedir/$dir" ]; then
      cd $basedir/$dir
      echo "Processing folder:" `pwd`
      echo "  \"${dir}\": [" >> $index
      find -maxdepth 1 -name '*.gf' | while read -r file
      do
          gf --batch --quiet --tags --output-dir=${tagsdir} $file 2>/dev/null
          echo "    \""`echo $file | sed 's|./||;s|.gf||'`"\"," >> $index
      done
      echo "    \"\"\n  ]," >> $index
  fi
done
echo "  \"\":{}\n}\n}" >> $index

# Replace all URLs
echo "Replacing URLs"
cd $tagsdir
sed -i "s|${removeprefix}||g" *.gf-tags

exit 0
