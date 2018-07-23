# GF's Resource Grammar Library (RGL)

The contents of this repository have been split from the original monolithic GF repository here: <https://github.com/GrammaticalFramework/GF/tree/master/lib>

## Requirements

In order to build the RGL, you will need:
- GF installed on your system
- Haskell

A method for building the RGL without Haskell is in the works.

## Basic usage

If you have `make`, you can compile the RGL and install it to the default location (see note below) with:

```
make install
```

This is the same as `make build` followed by `make copy`.
There is also `make clean` available.

### Install location

The install script will try to determine where to copy the compiled RGL modules.
It will look for, in this order:
- the `--dest=` flag (see below)
- the `GF_LIB_PATH` environment variable
- the file `../gf-core/GF_LIB_PATH` (relative to this directory). This only works if you have the `gf-core` and `gf-rgl` repositories in the same top-level directory **and** you have already compiled GF from source.
(This is considered messy and will probably disappead in the future)

## Advanced

For more fine-grained control over the build process, you can run the build script directly:

```
runghc Make.hs ...
```

Where `...` is one of:
```
build   [CMD] [MODE] [--langs=[+|-]LANG,LANG,...] [--gf=...]
copy    [--dest=...]
install [CMD] [MODE] [--langs=[+|-]LANG,LANG,...] [--gf=...] [--dest=...]
clean
```

- `CMD` is one of:
`prelude`,
`all`,
`lang`,
`api`,
`compat`,
`pgf`,
`parse`
(default is `all`)
- `MODE` is one of:
`present`,
`alltenses`
(default is both)
- You can _override_ the default language list with `--langs=...`
- You can _add_ languages to the default list with `--langs=+...`
- You can _remove_ languages from the default list with `langs=-...`
- `LANG` is a 3-letter language code, e.g. `Eng`, `Swe` etc.
- The path to GF installed on your system can be specified via the `gf` flag (default is that the `gf` executable is in the global system path).
- The `to` flag can be used to manually specify where the compiled RGL modules should be copied/installed. This is the same place as `GF_LIB_PATH`.
