rm -rf grammars
mkdir -pv grammars
mkdir -pv grammars/letter
mkdir -pv grammars/logic
mkdir -pv grammars/basic
mkdir -pv grammars/numerals
mkdir -pv grammars/prelude
mkdir -pv grammars/resource
mkdir -pv grammars/resource/abstract
mkdir -pv grammars/resource/english
mkdir -pv grammars/resource/finnish
mkdir -pv grammars/resource/french
mkdir -pv grammars/resource/german
mkdir -pv grammars/resource/italian
mkdir -pv grammars/resource/romance
mkdir -pv grammars/resource/russian
mkdir -pv grammars/resource/swedish
mkdir -pv grammars/database
mkdir -pv grammars/imperative
mkdir -pv grammars/imperative/compiler

cp -pv letter/README grammars/letter/
cp -pv letter/mkLetter.gfs grammars/letter/
cp -pv letter/*.gf grammars/letter/

cp -pv logic/*.gf grammars/logic/

cp -pv newnumerals/README grammars/numerals/
cp -pv newnumerals/*.gf grammars/numerals/
cp -pv newnumerals/mkNumerals.gfs grammars/numerals/

cp -pv basic/README grammars/basic/
cp -pv basic/*.gf grammars/basic/

cp -pv prelude/README grammars/prelude/
cp -pv prelude/*.gf grammars/prelude/

cp -pv newresource/mkTest.gfs grammars/resource/
cp -pv newresource/mkParadigms.gfs grammars/resource/
cp -pv newresource/README grammars/resource/
cp -pv newresource/abstract/*.gf grammars/resource/abstract/
cp -pv newresource/english/*.gf grammars/resource/english/
rm -f  grammars/resource/english/ResLex*
cp -pv newresource/finnish/*.gf grammars/resource/finnish/
cp -pv newresource/french/*.gf grammars/resource/french/
cp -pv newresource/german/*.gf grammars/resource/german/
cp -pv newresource/italian/*.gf grammars/resource/italian/
cp -pv newresource/romance/*.gf grammars/resource/romance/
cp -pv newresource/russian/*.gf grammars/resource/russian/
cp -pv newresource/swedish/*.gf grammars/resource/swedish/

cp -pv database/README grammars/database/
cp -pv database/*.gf grammars/database/

cp -pv imperative/*.gf grammars/imperative/
cp -pv imperative/compiler/*.hs grammars/imperative/compiler/
cp -pv imperative/compiler/README grammars/imperative/compiler/
cp -pv imperative/compiler/FILES grammars/imperative/compiler/
cp -pv imperative/compiler/gfcc grammars/imperative/compiler/
cp -pv imperative/compiler/makefile grammars/imperative/compiler/
cp -pv imperative/compiler/*.c grammars/imperative/compiler/
cp -pv imperative/compiler/*.gfs grammars/imperative/compiler/
cp -pv imperative/compiler/runtime.j grammars/imperative/compiler/


tar cvfz gf-grammars.tgz grammars

