#!/bin/tcsh

######################################################################
# Author: Peter Ljunglöf
# Time-stamp: "2005-02-03, 16:21"
# CVS $Date: 2005/02/03 15:23:02 $
# CVS $Author: peb $
#
# a script for producing documentation through Haddock
######################################################################

set base = `pwd`
set docdir = $base/haddock
set resourcedir = $base/haddock-resources

set dirs = (. api compile grammar infra shell source canonical useGrammar cf newparsing parsers notrace cfgm speech visualization for-ghc)
set rmfiles = {Lex,Par}{CFG,GF,GFC}.hs

######################################################################

echo 0. Creating and cleaning Haddock directory

if (-d $docdir) then
    rm $docdir/*
else
    mkdir $docdir
endif

######################################################################

echo
echo 1. Selecting and copying Haskell files 

foreach d ($dirs) 
    echo -- Directory: $d
    cd $base/$d
    foreach f (*.hs) 
	tr "\240" " " < $f > $docdir/$f
    end
end

######################################################################

echo
echo 2. Removing unnecessary files

cd $docdir
echo -- `ls $rmfiles`
rm $rmfiles

######################################################################

echo
echo 3. Invoking Haddock

cd $docdir
haddock -h -t 'Grammatical Framework' *.hs

######################################################################

echo
echo 4. Restructuring to HTML framesets

cd $docdir
echo -- Substituting for frame targets inside html files
mv index.html index-frame.html
foreach f (*.html) 
    perl -pe 's/<HEAD/<HEAD><BASE TARGET="contents"/; s/"index.html"/"index-frame.html"/; s/(<A HREF = "\S*index\S*.html")/$1 TARGET="index"/' $f > tempfile
    mv tempfile $f
end

cd $resourcedir
echo -- Copying resource files:
echo -- `ls`
cp * $docdir

######################################################################

echo
echo 5. Finished
echo -- The documentation is located at:
echo -- $docdir/index.html

cd $base


