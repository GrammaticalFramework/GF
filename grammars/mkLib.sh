rm -rf ../lib
mkdir -pv lib
mkdir -pv lib/letter
# mkdir -pv lib/logic
mkdir -pv lib/numerals
mkdir -pv lib/prelude
mkdir -pv lib/resource
mkdir -pv lib/resource/abstract
mkdir -pv lib/resource/english
mkdir -pv lib/resource/finnish
mkdir -pv lib/resource/french
mkdir -pv lib/resource/german
mkdir -pv lib/resource/italian
mkdir -pv lib/resource/romance
mkdir -pv lib/resource/russian
mkdir -pv lib/resource/swedish
mkdir -pv lib/resource/doc
mkdir -pv lib/database

cp -pv letter/README lib/letter/
cp -pv letter/mkLetter.gfs lib/letter/
cp -pv letter/*.gf lib/letter/

# cp -pv logic/*.gf lib/logic/

cp -pv newnumerals/README lib/numerals/
cp -pv newnumerals/*.gf lib/numerals/
cp -pv newnumerals/mkNumerals.gfs lib/numerals/

cp -pv prelude/README lib/prelude/
cp -pv prelude/*.gf lib/prelude/

cp -pv newresource/mkTest.gfs lib/resource/
cp -pv newresource/mkParadigms.gfs lib/resource/
cp -pv newresource/README lib/resource/
cp -pv newresource/Makefile lib/resource/
cp -pv newresource/index.html lib/resource/
cp -pv newresource/abstract/*.gf lib/resource/abstract/
cp -pv newresource/english/*.gf lib/resource/english/
cp -pv newresource/finnish/*.gf lib/resource/finnish/
cp -pv newresource/french/*.gf lib/resource/french/
cp -pv newresource/german/*.gf lib/resource/german/
cp -pv newresource/italian/*.gf lib/resource/italian/
cp -pv newresource/romance/*.gf lib/resource/romance/
cp -pv newresource/russian/*.gf lib/resource/russian/
cp -pv newresource/swedish/*.gf lib/resource/swedish/

cp -pv database/README lib/database/
cp -pv database/*.gf lib/database/

mv lib ..

cd ../lib/resource
make gfdoc
