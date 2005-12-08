#!/bin/sh

for f in lib/*.tra examples/*.tra; do 
    ./transferc -ilib $f; 
done
