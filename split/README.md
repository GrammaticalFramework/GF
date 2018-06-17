# Splitting `GF` into multiple repositories

See the [gf-dev thread](https://groups.google.com/d/topic/gf-dev/fedRMIi44pE/discussion).

The contents of this directory contain everything necessary (shell script and updated files) for performing the split.
This is a work-in-progress; once finalised, the split will be run on the latest of the `GF` repository and that repository will become frozen as an archive.

Contributions and comments welcome.

## Decisions

- When HTML is generated from some other format, e.g. txt2tags, the HTML should not be under version control.

## Questions

- Active RGL documentation and web availability
- Should current `GF` become an archive OR should it live on as main repo?
  Related names: `gf-core`, `gf-archive`

## To check

- `gf-rgl:doc` contains lots of stuff which is probably outdated

## Things which should live separately

- Android app `GF:src/ui/android`
- iOS app `GF:src/ui/ios`

**Done**
- RGL Source Browser `GF:lib/doc/browse`
- gftest `GF:src/tools/gftest`


## Things which should definitely be archived

- `GF:src/ui/gwt`
- `GF:src/tools/c`
- `GF:src/tools/c++`

---

## Filtering and shrinking a repository

```
cp -R GF-pristine rgl-source-browser
cd rgl-source-browser
git filter-branch --prune-empty --subdirectory-filter lib/doc/browse --tag-name-filter cat -- --all master
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git reflog expire --expire=now --all
git gc --prune=now
git remote set-url origin "git@github.com:GrammaticalFramework/rgl-source-browser.git"
git push --set-upstream origin master
```
