rm -rf gf-grammars
mkdir -pv gf-grammars
mkdir -pv gf-grammars/letter
# mkdir -pv gf-grammars/logic
mkdir -pv gf-grammars/numerals
mkdir -pv gf-grammars/prelude
mkdir -pv gf-grammars/resource
mkdir -pv gf-grammars/resource/abstract
mkdir -pv gf-grammars/resource/english
mkdir -pv gf-grammars/resource/finnish
mkdir -pv gf-grammars/resource/french
mkdir -pv gf-grammars/resource/german
mkdir -pv gf-grammars/resource/italian
mkdir -pv gf-grammars/resource/romance
mkdir -pv gf-grammars/resource/russian
mkdir -pv gf-grammars/resource/swedish
mkdir -pv gf-grammars/database

cp -pv letter/README gf-grammars/letter/
cp -pv letter/mkLetter.gfs gf-grammars/letter/
cp -pv letter/*.gf gf-grammars/letter/

# cp -pv logic/*.gf gf-grammars/logic/

cp -pv newnumerals/README gf-grammars/numerals/
cp -pv newnumerals/*.gf gf-grammars/numerals/
cp -pv newnumerals/mkNumerals.gfs gf-grammars/numerals/

cp -pv prelude/README gf-grammars/prelude/
cp -pv prelude/*.gf gf-grammars/prelude/

cp -pv newresource/mkTest.gfs gf-grammars/resource/
cp -pv newresource/mkParadigms.gfs gf-grammars/resource/
cp -pv newresource/README gf-grammars/resource/
cp -pv newresource/abstract/*.gf gf-grammars/resource/abstract/
cp -pv newresource/english/*.gf gf-grammars/resource/english/
cp -pv newresource/finnish/*.gf gf-grammars/resource/finnish/
cp -pv newresource/french/*.gf gf-grammars/resource/french/
cp -pv newresource/german/*.gf gf-grammars/resource/german/
cp -pv newresource/italian/*.gf gf-grammars/resource/italian/
cp -pv newresource/romance/*.gf gf-grammars/resource/romance/
cp -pv newresource/russian/*.gf gf-grammars/resource/russian/
cp -pv newresource/swedish/*.gf gf-grammars/resource/swedish/

cp -pv database/README gf-grammars/database/
cp -pv database/*.gf gf-grammars/database/

tar cvfz gf-grammars.tgz gf-grammars
