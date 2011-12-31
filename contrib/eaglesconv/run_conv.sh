#!/bin/sh
./EaglesConv "$@" +RTS -K256M -RTS > convtmp
./mkConcrete.sh convtmp > DictRus.gf
./mkAbstract.sh convtmp > DictRusAbs.gf
