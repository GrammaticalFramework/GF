#!/bin/sh

# Split this repository into smaller repositories
# Only tested with macOS

# Exit on error
set -e

# --- Config settings ---------------------------------------------------------

# Directory where the new split repositories will live
# Can be overridden when running the script with -d /PATH/TO/DIR
DIR="/Users/john/repositories/GF-SPLIT"

# Repository names
REP_PRISTINE="pristine"
REP_CORE="gf-core"
REP_RGL="gf-rgl"

# Push to remotes?
PUSH="true"

# Text prefix to include in commit messages created by this script
COMMIT_PREFIX="[GF Split] "

# Directory name suffix for backups
BACKUP_SUFFIX="_copy"

# --- Are you sure? -----------------------------------------------------------

echo "GF repository split script"
echo "Usage: run.sh [-d PATH] [-y]"
echo

CONFIRM=""
while getopts "yd:" FLAG; do
  case "$FLAG" in
    y) CONFIRM="true" ;;
    d) DIR="$OPTARG" ;;
    *) exit 1
  esac
done

if [ "$CONFIRM" != true ]; then
  echo "This script will [re]create the following directories:"
  echo "  ${DIR}/${REP_PRISTINE}"
  echo "  ${DIR}/${REP_CORE}"
  echo "  ${DIR}/${REP_RGL}"
  echo "  ${DIR}/${REP_CORE}${BACKUP_SUFFIX}"
  echo "  ${DIR}/${REP_RGL}${BACKUP_SUFFIX}"
  echo "To change the path, set the DIR variable in this script or use the -d flag."
  echo "When you are sure, re-run this script with the -y flag."
  exit 0
fi

# --- Setting up --------------------------------------------------------------

# Make a brand new clone which is copied for each sub repo
mkdir -p "$DIR"
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
# - remove RGL (filter out lib directory)
# - shrink
# - update build scripts
echo
echo "# ${REP_CORE}"

echo "Copying..."
cp -R "$REP_PRISTINE" "$REP_CORE"

echo "Cleaning..."
cd "$REP_CORE"
RM_DIRS="lib split"

echo "Filtering (this will take some time)..."
# git filter-branch --tree-filter "rm -rf ${RM_DIRS}" --prune-empty HEAD
git filter-branch --index-filter "git rm --cached --ignore-unmatch --quiet -r -- ${RM_DIRS}" --prune-empty HEAD
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d

echo "Shrinking..."
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo "Backing up shrunk repository..."
cd ..
cp -R "$REP_CORE" "${REP_CORE}${BACKUP_SUFFIX}"
cd "$REP_CORE"

echo "Post-split updates..."
CP_FILES="Setup.hs"
for FILE in $CP_FILES ; do
  cp "${DIR}/${REP_PRISTINE}/split/${REP_CORE}/${FILE}" .
done
git apply "${DIR}/${REP_PRISTINE}/split/${REP_CORE}/diff.patch"
git add .
git commit -m "${COMMIT_PREFIX}Post-split updates" --quiet

echo "Set origin to git@github.com:GrammaticalFramework/${REP_CORE}.git"
git remote set-url origin "git@github.com:GrammaticalFramework/${REP_CORE}.git"
if [ "$PUSH" = true ]; then
  echo "Pushing..."
  git push --set-upstream --force origin master
fi
cd ..

# === RGL ===
# - filter just `lib` directory
# - shrink
# - clean up
# - update build scripts
echo
echo "# ${REP_RGL}"

echo "Copying..."
cp -R -- "$REP_PRISTINE" "$REP_RGL"

echo "Filtering (this will take some time)..."
cd "$REP_RGL"
git filter-branch --prune-empty --subdirectory-filter lib --tag-name-filter cat -- --all

# echo "Cloning..."
# cd ..
# git clone "file://`pwd`/$REP_RGL" "${REP_RGL}_cloned"
# rm -rf "$REP_RGL"
# mv "${REP_RGL}_cloned" "$REP_RGL"
# cd "$REP_RGL"

echo "Shrinking..."
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git reflog expire --expire=now --all
git gc --prune=now

echo "Backing up shrunk repository..."
cd ..
cp -R "$REP_RGL" "${REP_RGL}${BACKUP_SUFFIX}"
cd "$REP_RGL"

echo "Post-split updates..."
git rm -r --quiet doc/browse
git commit -m "${COMMIT_PREFIX}Remove RGL browser" --quiet

CP_FILES=".gitignore Make.hs Makefile README.md"
for FILE in $CP_FILES ; do
  cp "${DIR}/${REP_PRISTINE}/split/${REP_RGL}/${FILE}" .
done
git add .
git rm --quiet "src/Makefile"
git mv "src/mkPresent" .
git commit -m "${COMMIT_PREFIX}Post-split updates" --quiet

echo "Set origin to git@github.com:GrammaticalFramework/${REP_RGL}.git"
git remote set-url origin "git@github.com:GrammaticalFramework/${REP_RGL}.git"
if [ "$PUSH" = true ]; then
  echo "Pushing..."
  git push --set-upstream --force origin master
fi
cd ..

# --- Finally ----------------------------------------------------------------
echo
echo "Done. Your new repositories are at:"
echo "  ${DIR}/${REP_CORE}"
echo "  ${DIR}/${REP_RGL}"

echo "You may want to delete these repositories:"
echo "  ${DIR}/${REP_PRISTINE}"
echo "  ${DIR}/${REP_CORE}${BACKUP_SUFFIX}"
echo "  ${DIR}/${REP_RGL}${BACKUP_SUFFIX}"
