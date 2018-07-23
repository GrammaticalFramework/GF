#!/bin/sh

# Non-Haskell RGL build script for Unix-based machines

modules_langs="All Symbol Compatibility"
modules_api="Try Symbolic"

# Defaults (may be overridden by options)
gf="gf"
dest=""

# Check command line options
for arg in "$@"; do
  case $arg in
    --gf=*)
      gf="${arg#*=}"; shift ;;
    --dest=*)
      dest="${arg#*=}"; shift ;;
    *) echo "Unknown option: ${arg}" ; exit 1 ;;
  esac
done

# Try to determine install location
if [ -z "$dest" ]; then
  dest="$GF_LIB_PATH"
fi
if [ -z "$dest" ] && [ -f "../gf-core/GF_LIB_PATH" ]; then
  dest=`cat ../gf-core/GF_LIB_PATH`
fi
if [ -z "$dest" ]; then
  echo "Unable to determine where to install the RGL. Please do one of the following:"
  echo " - Pass the --dest=... flag to this script"
  echo " - Set the GF_LIB_PATH environment variable"
  echo " - Compile GF from the gf-core repository (must be in same directory as gf-rgl)"
  exit 1
fi

# A few more definitions before we get started
src="src"
dist="dist"
gfc="${gf} -batch -gf-lib-path=${src} -s "

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
