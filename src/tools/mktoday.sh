#!/bin/sh

echo 'module GF.Today (today,version) where' > GF/Today.hs
echo '{-# NOINLINE today #-}' >> GF/Today.hs
echo 'today,version :: String' >> GF/Today.hs
echo 'today = "'`date`'"' >> GF/Today.hs
echo 'version = "'$1'"' >> GF/Today.hs

