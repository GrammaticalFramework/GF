rm -rf ../lib
mkdir -p lib
mkdir -p lib/letter
# mkdir -p lib/logic
mkdir -p lib/numerals
mkdir -p lib/prelude
mkdir -p lib/resource
mkdir -p lib/resource/abstract
mkdir -p lib/resource/english
mkdir -p lib/resource/finnish
mkdir -p lib/resource/french
mkdir -p lib/resource/german
mkdir -p lib/resource/italian
mkdir -p lib/resource/romance
mkdir -p lib/resource/russian
mkdir -p lib/resource/swedish
mkdir -p lib/resource/doc
mkdir -p lib/database

cp -p letter/README lib/letter/
cp -p letter/mkLetter.gfs lib/letter/
cp -p letter/*.gf lib/letter/

# cp -p logic/*.gf lib/logic/

cp -p newnumerals/README lib/numerals/
cp -p newnumerals/*.gf lib/numerals/
cp -p newnumerals/mkNumerals.gfs lib/numerals/

cp -p prelude/README lib/prelude/
cp -p prelude/*.gf lib/prelude/

cp -p newresource/mkTest.gfs lib/resource/
cp -p newresource/mkParadigms.gfs lib/resource/
cp -p newresource/README lib/resource/
cp -p newresource/Makefile lib/resource/
cp -p newresource/index.html lib/resource/
cp -p newresource/abstract/*.gf lib/resource/abstract/
cp -p newresource/english/*.gf lib/resource/english/
cp -p newresource/finnish/*.gf lib/resource/finnish/
cp -p newresource/french/*.gf lib/resource/french/
cp -p newresource/german/*.gf lib/resource/german/
cp -p newresource/italian/*.gf lib/resource/italian/
cp -p newresource/romance/*.gf lib/resource/romance/
cp -p newresource/russian/*.gf lib/resource/russian/
cp -p newresource/swedish/*.gf lib/resource/swedish/
cp -p newresource/doc/*.html lib/resource/doc/

cp -p database/README lib/database/
cp -p database/*.gf lib/database/

mv lib ..
