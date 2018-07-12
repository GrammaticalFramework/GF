# GF's Resource Grammar Library (RGL)

Recently split off into a separate repository from <https://github.com/GrammaticalFramework/GF/tree/master/lib>

## Simple

```
make
```

## Advanced

```
runghc Make.hs ...
```

Where `...` is one of:
```
build [CMD] [MODE] [langs=LANG,LANG,...]
copy
install [CMD] [MODE] [langs=LANG,LANG,...]
clean
```

Where `CMD`:
- prelude
- all
- lang
- api
- compat
- pgf
- demo
- parse
Default: prelude,all

Where `MODE`:
- present
- alltenses
Default: present,alltenses

Where `LANG` is a 3-letter language code `Eng`, `Swe` etc.
