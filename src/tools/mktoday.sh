#!/bin/sh

echo 'module GF.Today (today) where' > GF/Today.hs
echo 'today :: String' >> GF/Today.hs
echo 'today = "'`date`'"' >> GF/Today.hs

