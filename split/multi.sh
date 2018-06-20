#!/bin/sh

# Detach many subdirectories into a new, separate Git repository
# Source: https://stackoverflow.com/a/42298777/98600

# working directory (absolute or relative to current directory where script is run)
wd="/Users/john/repositories/GF-SPLIT/test-multi"
# wd="."

# original repository (relative to $wd)
pristine="../pristine"

# name and remote of new repo
# leave remote blank to avoid pushing
newrepo="wide-coverage"
newremote="git@github.com:GrammaticalFramework/wide-coverage.git"

# paths from original repository
# with corresponding subdirs for new repo
paths=("examples/app" "lib/src/chunk" "lib/src/translator")
subs=( "app"          "chunk"         "translator")

# Start
set -e
mkdir -p "$wd"
cd "$wd"

# Pull
echo "Pulling ${pristine}"
cd "$pristine"
git pull
git clean -x --force
cd "$wd"

# Filter
for i in "${!subs[@]}"
do
  sub=${subs[$i]}
  path=${paths[$i]}
  repo="repo-${sub}"
  echo "Filtering ${repo}"

  cp -R "$pristine" "$repo"
  cd "$repo"
  git filter-branch --prune-empty --subdirectory-filter "$path" master
  cd ..
done

# Set up new repo
echo "Setting up ${newrepo}"
mkdir "$newrepo"
cd "$newrepo"
git init
touch README.md
git add README.md
git commit -m "Add README.md"

# Merges
for i in "${!subs[@]}"
do
  sub=${subs[$i]}
  repo="repo-${sub}"
  echo "Merging ${repo}"

  git remote add "$repo" "../${repo}"
  git fetch "$repo"
  git merge -s ours --no-commit --allow-unrelated-histories "${repo}/master"
  git read-tree --prefix=${sub} -u "${repo}/master"
  git commit -m "Import ${sub}"
  git remote remove "$repo"
done

echo "Shrinking"
git reflog expire --expire=now --all
git gc --prune=now --aggressive

if [ -n "$newremote" ]; then
  echo "Pushing"
  git remote add origin "$newremote"
  git push --set-upstream origin master
fi

echo "Cleaning up"
cd ..
for i in "${!subs[@]}"
do
  sub=${subs[$i]}
  repo="repo-${sub}"
  rm -rf "$repo"
done
