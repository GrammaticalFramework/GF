#!/bin/sh

FILES="darcs.txt transfer-reference.txt transfer-tutorial.txt \
      transfer.txt"

for f in $FILES; do
  h=`basename "$f" ".txt"`.html
  if [ "$f" -nt "$h" ]; then 
    txt2tags $f
  else
    echo "$h is newer than $f, skipping"
  fi
done
