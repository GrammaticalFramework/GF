#!/bin/sh

# Split this repository into smaller repositories
# Only tested with macOS

# --- Config settings ---------------------------------------------------------

# Exit on error
set -e

# Push to remotes?
PUSH=false

# Text prefix to include in commit messages created by this script
COMMIT_PREFIX="[GF Split] "

# Directory where the new split repositories will live
# https://stackoverflow.com/a/246128/98600
THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR="${THISDIR}/../../GF-SPLIT/"
mkdir -p "$DIR"

# Repository names
REP_PRISTINE="GF-pristine"
REP_CORE="gf-core"
REP_RGL="gf-rgl"
REP_ARCHIVE="gf-archive"

# --- Setting up --------------------------------------------------------------

# Make a brand new clone which is copied for each sub repo
cd "$DIR"
echo "# $REP_PRISTINE"
if [ -d "$REP_PRISTINE" ]; then
  echo "Pulling..."
  cd "$REP_PRISTINE"
  git pull --quiet
  echo "Cleaning..."
  git clean -x --force
  cd ..
else
  echo "Cloning..."
  git clone git@github.com:GrammaticalFramework/GF.git "$REP_PRISTINE"
fi

rm -rf "$REP_CORE"
rm -rf "$REP_RGL"

# --- Begin building repos ----------------------------------------------------

# === core ===
# - remove non-core stuff, preserving general structure
# - TODO changes to build scripts
echo
echo "# ${REP_CORE}"

echo "Copying..."
cp -R -- "$REP_PRISTINE" "$REP_CORE"

echo "Cleaning..."
cd "$REP_CORE"
git rm -r --quiet css demos doc download eclipse examples framenet gf-book treebanks *.html
git commit -m "${COMMIT_PREFIX}Remove everything non-core" --quiet

git remote set-url origin "git@github.com:GrammaticalFramework/${REP_CORE}.git"
if [ "$PUSH" = true ]; then
  echo "Pushing..."
  git push -u origin master
fi
cd ..

# === RGL ===
# - filter `lib` directory
# - minor clean up
# - TODO build scripts
echo
echo "# ${REP_RGL}"

echo "Copying..."
cp -R -- "$REP_PRISTINE" "$REP_RGL"

echo "Pruning..."
cd "$REP_RGL"
git filter-branch --prune-empty --subdirectory-filter lib master

# echo "Cleaning..."
# git rm -r --quiet doc/browse
# git commit -m "${COMMIT_PREFIX}Remove RGL browser (separate repo)" --quiet

git remote set-url origin "git@github.com:GrammaticalFramework/${REP_RGL}.git"
if [ "$PUSH" = true ]; then
  echo "Pushing..."
  git push -u origin master
fi
cd ..

# --- Finally -----------------------------------------------------------------

# TODO rename/change remote for GF-archive?
