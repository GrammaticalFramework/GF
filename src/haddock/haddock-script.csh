#!/bin/tcsh

######################################################################
# Author: Peter Ljunglöf
# Time-stamp: "2005-03-29, 13:55"
# CVS $Date: 2005/03/29 11:58:45 $
# CVS $Author: peb $
#
# a script for producing documentation through Haddock
######################################################################

# set base = `pwd`
set docdir = haddock
set tempdir = .haddock-temp-files
set resourcedir = haddock-resources

#set dirs = (. api compile grammar infra shell source canonical useGrammar cf newparsing parsers notrace cfgm speech visualization for-hugs for-ghc)

set files = (`find * -name '*.hs' -not -path 'old-stuff/*' -not -path 'for-*' -not -path 'haddock*' -not -name 'Lex[GC]*' -not -name 'Par[GC]*'` $base/for-ghc-nofud/*.hs)

######################################################################

echo 1. Creating and cleaning Haddock directory
echo -- $docdir 

mkdir -p $docdir
rm -r $docdir/*

######################################################################

echo
echo 2. Copying Haskell files to temporary directory ($tempdir)

rm -r $tempdir

foreach f ($files) 
    echo -- $f
    mkdir -p `dirname $tempdir/$f`
    perl -e 's/^#/-- CPP #/' $f > $tempdir/$f
end

######################################################################

# set rmfiles = {Lex,Par}{CFG,GF,GFC}.hs

# echo
# echo 2. Removing unnecessary files

# cd $docdir
# echo -- `ls $rmfiles`
# rm $rmfiles

######################################################################

echo
echo 3. Invoking Haddock

cd $tempdir
haddock -o ../$docdir -h -t 'Grammatical Framework' $files
cd ..

######################################################################

echo
echo 4. Restructuring to HTML framesets

echo -- Substituting for frame targets inside html files
mv $docdir/index.html $docdir/index-frame.html
foreach f ($docdir/*.html) 
    perl -pe 's/<HEAD/<HEAD><BASE TARGET="contents"/; s/"index.html"/"index-frame.html"/; s/(<A HREF = "\S*index\S*.html")/$1 TARGET="index"/' $f > .tempfile
    mv .tempfile $f
end

echo -- Copying resource files:
echo -- `ls $resourcedir/*.*`
cp $resourcedir/*.* $docdir

######################################################################

echo
echo 5. Finished
echo -- The documentation is located at:
echo -- $docdir/index.html


