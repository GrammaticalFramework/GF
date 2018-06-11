#!/bin/sh

# Split this repository into smaller repositories
# Only tested with macOS

# Exit on error
set -e

# directory where the new split repositories will live
DIR=../../gf-split/
mkdir -p $DIR

# Make a brand new clone which is copied for each sub repo
REP_PRISTINE=GF-pristine
cd $DIR
echo "# ${REP_PRISTINE}"
if [ -d $REP_PRISTINE ]; then
  echo "Pulling..."
  cd $REP_PRISTINE
  git pull
  cd ..
else
  echo "Cloning..."
  git clone git@github.com:GrammaticalFramework/GF.git $REP_PRISTINE
fi

# repository names
REP_RGL=gf-rgl

# initial cleanup
rm -rf ${REP_RGL}

# RGL
echo
echo "# ${REP_RGL}"
echo "Copying..."
cp -R $REP_PRISTINE $REP_RGL
echo "Pruning..."
cd $REP_RGL
git filter-branch --prune-empty --subdirectory-filter lib master
git remote set-url origin https://github.com/GrammaticalFramework/${REP_RGL}.git
# @echo "Pushing..."
# git push -u origin master
