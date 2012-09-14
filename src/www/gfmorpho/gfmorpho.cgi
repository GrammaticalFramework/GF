#!/bin/bash

echo "Content-type: text/html";
echo ""
export LANG=en_US.UTF-8
export GF_LIB_PATH=/home/aarne/GF/lib/
/usr/local/bin/runghc GFMorpho "$QUERY_STRING"
