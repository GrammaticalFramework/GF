#!/bin/tcsh

######################################################################
# Author: Peter Ljunglöf
# Time-stamp: "2005-02-18, 14:26"
# CVS $Date: 2005/02/18 19:21:06 $
# CVS $Author: peb $
#
# a script for producing documentation through Haddock
######################################################################

set base = `pwd`
set docdir = $base/haddock
set resourcedir = $base/haddock-resources

#set dirs = (. api compile grammar infra shell source canonical useGrammar cf newparsing parsers notrace cfgm speech visualization for-hugs for-ghc)

set files = (`find $base -name '*.hs' -not -path '*/conversions/*' -not -path '*/parsing/*' -not -path '*/for-*' -not -path '*/haddock*' -not -name 'Lex[GC]*' -not -name 'Par[GC]*'` $base/for-ghc-nofud/*.hs)

######################################################################

echo 1. Creating and cleaning Haddock directory
echo -- $docdir

mkdir -p $docdir
rm -r $docdir/*

######################################################################

# echo
# echo 2. Selecting and soft linking Haskell files 

# foreach d ($dirs) 
#     echo -- Directory: $d
#     cd $base/$d
#     foreach f (*.hs) 
#         ln -fs $base/$d/$f $docdir/$f
# 	# tr "\240" " " < $f > $docdir/$f
#     end
# end

######################################################################

# set rmfiles = {Lex,Par}{CFG,GF,GFC}.hs

# echo
# echo 2. Removing unnecessary files

# cd $docdir
# echo -- `ls $rmfiles`
# rm $rmfiles

######################################################################

echo
echo 2. Invoking Haddock

# cd $docdir
haddock -o $docdir -h -t 'Grammatical Framework' $files

######################################################################

echo
echo 3. Restructuring to HTML framesets

cd $docdir
echo -- Substituting for frame targets inside html files
mv index.html index-frame.html
foreach f (*.html) 
    perl -pe 's/<HEAD/<HEAD><BASE TARGET="contents"/; s/"index.html"/"index-frame.html"/; s/(<A HREF = "\S*index\S*.html")/$1 TARGET="index"/' $f > tempfile
    mv tempfile $f
end

cd $resourcedir
echo -- Copying resource files:
echo -- `ls *.*`
cp *.* $docdir

######################################################################

echo
echo 4. Finished
echo -- The documentation is located at:
echo -- $docdir/index.html

cd $base


