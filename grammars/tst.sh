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
rm -f TestAll.gfcm
cd ../database
echo "gr -number=8 | l" | gf -path=.:../resource/abstract:../resource/english:../resource/swedish:../prelude -noemit RestaurantEng.gf RestaurantSwe.gf
cd ../resource
rm -f */*.gfc */*.gfr
rm -f ../prelude/*.gfc ../prelude/*.gfr

