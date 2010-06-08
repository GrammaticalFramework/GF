#!/bin/sh

# GF C Bindings
# Copyright (C) 2008-2010 Kevin Kofler
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, see <http://www.gnu.org/licenses/>.
src=../../src
import=-i$src/runtime/haskell:$src/compiler
gf --make ../../examples/tutorial/embedded/QueryEng.gf &&
ghc $import --make -fglasgow-exts -O2 -no-hs-main $* -c PGFFFI.hs &&
ghc $import --make -fglasgow-exts -O2 -no-hs-main $* gfctest.c gf_lexing.c PGFFFI.hs -o gfctest
