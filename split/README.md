# Splitting `GF` into multiple repositories

See the [gf-dev thread](https://groups.google.com/d/topic/gf-dev/fedRMIi44pE/discussion).

This directory contains everything necessary (shell script and updated files) for performing the split.
This is a work-in-progress; once finalised, the split will be run on the latest of the `GF` repository and that repository will become frozen as an archive.

Contributions and comments welcome.

## Checklist

- [x] Beta testing of build scripts
- [ ] Package-building scripts
- [x] Webpage setup to follow new repositories
- [ ] GF Developers documentation
- [ ] RGL Documentation
- [ ] Update GF web styles
- [ ] Script for auto-rendering Markdown

## To check

- `gf-rgl:doc` contains lots of stuff which is probably outdated
- `GF:demos`
- `GF:treebanks`

### Things which should live separately

- Android app `GF:src/ui/android`
- iOS app `GF:src/ui/ios`

**Done**
- RGL Source Browser `GF:lib/doc/browse`
- gftest `GF:src/tools/gftest`
- `GF:examples`

### Things which should definitely be archived

- `GF:src/ui/gwt`
- `GF:src/tools/c`
- `GF:src/tools/c++`

---

## Git commands

### Filtering and shrinking
Source: https://git-scm.com/docs/git-filter-branch#_checklist_for_shrinking_a_repository
```
git filter-branch --prune-empty --subdirectory-filter <DIR> --tag-name-filter cat -- --all
```

*Shrink via clone (safer)*
```
cd ..
git clone file://`pwd`/<REPO> <REPO_CLONED>
rm -rf <REPO>
mv <REPO_CLONED> <REPO>
cd <REPO>
```

*Shrink manually (more destructive)*
```
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git reflog expire --expire=now --all
git gc --prune=now
```

### Remove contents from history
Source: https://stackoverflow.com/questions/10067848/remove-folder-and-its-contents-from-git-githubs-history/
```
git filter-branch --tree-filter 'rm -rf <DIR>' --prune-empty HEAD
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
```
This works but is very slow.
Slightly faster:

```
git filter-branch --index-filter 'git rm --cached --ignore-unmatch --quiet -r -- <DIR>' --prune-empty HEAD
...
```

### [BFG](https://rtyley.github.io/bfg-repo-cleaner/)
A faster alternative to method above.  
**NOTE 1:** this only works because the directory name `lib` is unique in the `GF` repository; otherwise it would be too destructive.  
**NOTE 2:** it is not recommended to use `--no-blob-protection`; rather delete `/lib` in a regular commit and then proceed without this flag (but it's a few more steps).

```
cp -R pristine.git gf-core-bfg.git
bfg --delete-folders "lib" --no-blob-protection gf-core-bfg.git
cd gf-core-bfg.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
cd ..
git clone file://`pwd`/gf-core-bfg.git
cd gf-core-bfg
git remote set-url origin git@github.com:GrammaticalFramework/gf-core-bfg.git
```

### Check repository size
```
git gc && git count-objects -vH
```

### Aggressive cleaning
Source: https://rtyley.github.io/bfg-repo-cleaner/
```
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```
