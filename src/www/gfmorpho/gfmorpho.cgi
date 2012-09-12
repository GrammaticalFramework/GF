#!/bin/bash

echo "Content-type: text/html";
echo ""
export LANG=en_US.UTF-8
runghc GFMorpho "$QUERY_STRING"

