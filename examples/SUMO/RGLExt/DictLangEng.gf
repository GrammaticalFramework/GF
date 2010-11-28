--# -path=.:../../../lib/src/abstract:../../../lib/src/english:../../../lib/src/common

concrete DictLangEng of DictLang = 
  GrammarEng
  ** open ExtensionEng in {

flags  unlexer = text ; lexer = text ;

} ;
