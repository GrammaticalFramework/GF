#!/bin/sh

echo 'module Today (today) where' > Today.hs
echo 'today :: String' >> Today.hs
echo 'today = "'`date`'"' >> Today.hs

