#!/bin/sh

# Non-Haskell RGL build script for Unix-based machines

gf="gf"
gfc="${gf} -batch -gf-lib-path=src -s "
src="src"
dist="dist"
dest="/Users/john/repositories/GF/.cabal-sandbox/share/x86_64-osx-ghc-8.2.2/gf-3.9/lib"

modules_langs="All Symbol Compatibility"
modules_api="Try Symbolic"

# Make directories if not present
mkdir -p "${dist}/prelude"
mkdir -p "${dist}/present"
mkdir -p "${dist}/alltenses"

# Build: prelude
${gfc} --gfo-dir="${dist}"/prelude "${src}"/prelude/*.gf

# Gather all language modules for building
modules=""
for mod in $modules_langs; do
  res=`find "${src}"/* -type f -name "${mod}???.gf"`
  modules="${modules} $res"
done
for mod in $modules_api; do
  res=`find "${src}"/api -type f -name "${mod}???.gf"`
  modules="${modules} $res"
done

# Build: present
${gfc} -no-pmcfg --gfo-dir="${dist}"/present -preproc=mkPresent "${modules}"

# Build: alltenses
${gfc} -no-pmcfg --gfo-dir="${dist}"/alltenses "${modules}"

# Install
cp -R ${dist}/* ${dest}
