cd gf-grammars/numerals
gf <mkNumerals.gfs
echo "x=56789" | gft numerals.gfcm
rm numerals.gfcm
cd ../letter
gf <mkLetter.gfs
jgf Letter.gfcm
rm -f Letter.gfcm
cd ../resource
gf <mkTest.gfs
gf <mkParadigms.gfs
jgf TestAll.gfcm
rm -f */*.gfc */*.gfr
rm -f ../prelude/*.gfc ../prelude/*.gfr
rm -f TestAll.gfcm
